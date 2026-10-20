
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:qitai/features/client/products/domain/entities/product.dart';
import 'package:qitai/features/client/products/domain/entities/product_pagination.dart';
import 'package:qitai/features/client/products/domain/repositories/product_repository.dart';
import 'package:qitai/features/client/products/domain/usecases/get_products.dart';
import 'package:qitai/features/client/products/presentation/provider/product_provider.dart';

import 'package:qitai/features/client/search/domain/entities/search_suggestion.dart';
import 'package:qitai/features/client/search/domain/repositories/search_suggestions_repository.dart';
import 'package:qitai/features/client/search/domain/usecases/get_search_suggestions.dart';
import 'package:qitai/features/client/search/presentation/provider/search_notifier.dart';
import 'package:qitai/features/client/search/presentation/provider/search_suggestions_provider.dart';

import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_notifier.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_state.dart';

class FakeVehicleNotifier extends VehicleNotifier {
  @override
  VehicleState build() => const VehicleState();
}

class FakeSearchSuggestionsRepository
    implements SearchSuggestionRepository {
  @override
  Future<List<SearchSuggestion>> getSuggestions({
    required String query,
  }) async {
    return [];
  }
}

class ProductRequest {
  ProductRequest({
    required this.query,
    required this.page,
  });

  final String? query;
  final int page;

  final completer = Completer<ProductPagination>();
}

class FakeProductRepository implements ProductRepository {
  final requests = <ProductRequest>[];

  @override
  Future<ProductPagination> getProducts({
    String? query,
    String? vin,
    int? brandId,
    int? modelId,
    int? year,
    int? categoryId,
    int page = 1,
  }) {
    final request = ProductRequest(
      query: query,
      page: page,
    );

    requests.add(request);

    return request.completer.future;
  }
}

Product _product(int id) => Product(
      id: id,
      name: 'Product $id',
      sku: 'SKU-$id',
      partNumber: 'PART-$id',
      condition: 'new',
      quality: 'original',
      price: 100,
      stock: 10,
      inStock: true,
      images: const [],
      category: null,
    );

ProductPagination _result(
  int id, {
  int page = 1,
}) =>
    ProductPagination(
      products: [_product(id)],
      currentPage: page,
      lastPage: 2,
      perPage: 10,
      total: 20,
    );

void main() {
  test(
    'Old search pagination must not append to new search results',
    () async {
      final repository = FakeProductRepository();

      final container = ProviderContainer(
        overrides: [
          getProductsProvider.overrideWith(
            (ref) => GetProducts(repository),
          ),
          getSearchSuggestionsProvider.overrideWith(
            (ref) => GetSearchSuggestions(
              FakeSearchSuggestionsRepository(),
            ),
          ),
          vehicleProvider.overrideWith(
            FakeVehicleNotifier.new,
          ),
        ],
      );

      addTearDown(container.dispose);

      // Keep the autoDispose provider active.
      final subscription = container.listen(
        searchProvider,
        (_, _) {},
      );

      addTearDown(subscription.close);

      final notifier = container.read(
        searchProvider.notifier,
      );

      // First search: TOYOTA.
      final firstSearch = notifier.submitSearch(
        customQuery: 'TOYOTA',
      );

      expect(repository.requests.length, 1);
      expect(repository.requests[0].query, 'TOYOTA');
      expect(repository.requests[0].page, 1);

      repository.requests[0].completer.complete(
        _result(10),
      );

      await firstSearch;

      expect(
        container.read(searchProvider).products.first.id,
        10,
      );

      expect(
        container.read(searchProvider).hasNextPage,
        true,
      );

      // Start loading page 2 of TOYOTA.
      final oldPagination = notifier.loadNextPage();

      expect(repository.requests.length, 2);
      expect(repository.requests[1].query, 'TOYOTA');
      expect(repository.requests[1].page, 2);

      expect(
        container.read(searchProvider).isLoadingMore,
        true,
      );

      // Start a new search before old pagination returns.
      final newSearch = notifier.submitSearch(
        customQuery: 'HONDA',
      );

      expect(repository.requests.length, 3);
      expect(repository.requests[2].query, 'HONDA');
      expect(repository.requests[2].page, 1);

      // HONDA responds first.
      repository.requests[2].completer.complete(
        _result(200),
      );

      await newSearch;

      expect(
        container
            .read(searchProvider)
            .products
            .map((product) => product.id)
            .toList(),
        [200],
      );

      // Old TOYOTA pagination responds late.
      repository.requests[1].completer.complete(
        _result(100, page: 2),
      );

      await oldPagination;

      final state = container.read(searchProvider);

      // Old results must not be appended.
      expect(
        state.products.map((product) => product.id).toList(),
        [200],
      );

      expect(state.query, 'HONDA');
      expect(state.currentPage, 1);
      expect(state.isProductsLoading, false);
      expect(state.isLoadingMore, false);
      expect(state.errorMessage, isNull);
    },
  );
}
