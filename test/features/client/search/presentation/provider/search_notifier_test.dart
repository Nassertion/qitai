
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

class SuggestionRequest {
  SuggestionRequest(this.query);

  final String query;
  final completer = Completer<List<SearchSuggestion>>();
}

class FakeSearchSuggestionsRepository
    implements SearchSuggestionRepository {
  final requests = <SuggestionRequest>[];

  @override
  Future<List<SearchSuggestion>> getSuggestions({
    required String query,
  }) {
    final request = SuggestionRequest(query);
    requests.add(request);
    return request.completer.future;
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

ProviderContainer _createContainer(
  FakeProductRepository products,
  FakeSearchSuggestionsRepository suggestions,
) {
  return ProviderContainer(
    overrides: [
      getProductsProvider.overrideWith(
        (ref) => GetProducts(products),
      ),
      getSearchSuggestionsProvider.overrideWith(
        (ref) => GetSearchSuggestions(suggestions),
      ),
      vehicleProvider.overrideWith(
        FakeVehicleNotifier.new,
      ),
    ],
  );
}

void main() {
  test(
    'Old search pagination must not append to new search results',
    () async {
      final products = FakeProductRepository();
      final suggestions = FakeSearchSuggestionsRepository();

      final container = _createContainer(products, suggestions);
      addTearDown(container.dispose);

      final subscription = container.listen(searchProvider, (_, _) {});
      addTearDown(subscription.close);

      final notifier = container.read(searchProvider.notifier);

      final firstSearch = notifier.submitSearch(
        customQuery: 'TOYOTA',
      );

      expect(products.requests.length, 1);
      expect(products.requests[0].query, 'TOYOTA');
      expect(products.requests[0].page, 1);

      products.requests[0].completer.complete(_result(10));
      await firstSearch;

      expect(container.read(searchProvider).products.first.id, 10);
      expect(container.read(searchProvider).hasNextPage, true);

      final oldPagination = notifier.loadNextPage();

      expect(products.requests.length, 2);
      expect(products.requests[1].query, 'TOYOTA');
      expect(products.requests[1].page, 2);

      final newSearch = notifier.submitSearch(
        customQuery: 'HONDA',
      );

      expect(products.requests.length, 3);
      expect(products.requests[2].query, 'HONDA');
      expect(products.requests[2].page, 1);

      products.requests[2].completer.complete(_result(200));
      await newSearch;

      products.requests[1].completer.complete(
        _result(100, page: 2),
      );
      await oldPagination;

      final state = container.read(searchProvider);

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

  test(
    'Editing query must invalidate an in-flight product search',
    () async {
      final products = FakeProductRepository();
      final suggestions = FakeSearchSuggestionsRepository();

      final container = _createContainer(products, suggestions);
      addTearDown(container.dispose);

      final subscription = container.listen(searchProvider, (_, _) {});
      addTearDown(subscription.close);

      final notifier = container.read(searchProvider.notifier);

      final oldSearch = notifier.submitSearch(
        customQuery: 'TOYOTA',
      );

      expect(products.requests.length, 1);
      expect(container.read(searchProvider).isProductsLoading, true);

      notifier.onQueryChanged('HONDA');

      final editingState = container.read(searchProvider);

      expect(editingState.query, 'HONDA');
      expect(editingState.products, isEmpty);
      expect(editingState.hasSearched, false);

      products.requests[0].completer.complete(_result(100));
      await oldSearch;

      final state = container.read(searchProvider);

      expect(state.query, 'HONDA');
      expect(state.products, isEmpty);
      expect(state.hasSearched, false);
      expect(state.isProductsLoading, false);
      expect(state.isLoadingMore, false);
      expect(state.errorMessage, isNull);
    },
  );

  test(
    'Old suggestion error must not affect newer query',
    () async {
      final products = FakeProductRepository();
      final suggestions = FakeSearchSuggestionsRepository();

      final container = _createContainer(products, suggestions);
      addTearDown(container.dispose);

      final subscription = container.listen(searchProvider, (_, _) {});
      addTearDown(subscription.close);

      final notifier = container.read(searchProvider.notifier);

      // Start the old TOYOTA suggestions request.
      notifier.onQueryChanged('TOYOTA');

      final oldSuggestions = notifier.loadSuggestions('TOYOTA');

      expect(suggestions.requests.length, 1);
      expect(suggestions.requests[0].query, 'TOYOTA');

      // User changes the text to HONDA.
      notifier.onQueryChanged('HONDA');

      expect(container.read(searchProvider).query, 'HONDA');
      expect(container.read(searchProvider).errorMessage, isNull);

      // Let HONDA debounce fire and start its own request.
      await Future<void>.delayed(
        const Duration(milliseconds: 400),
      );

      expect(suggestions.requests.length, 2);
      expect(suggestions.requests[1].query, 'HONDA');

      // The new request is legitimately loading.
      expect(
        container.read(searchProvider).isSuggestionsLoading,
        true,
      );

      // The old TOYOTA request fails.
      suggestions.requests[0].completer.completeError(
        Exception('Old suggestions request failed'),
      );
      await oldSuggestions;

      final stateAfterOldError = container.read(searchProvider);

      expect(stateAfterOldError.query, 'HONDA');
      expect(stateAfterOldError.errorMessage, isNull);

      // HONDA may continue loading despite the old failure.
      expect(stateAfterOldError.isSuggestionsLoading, true);

      // The new HONDA request succeeds.
      suggestions.requests[1].completer.complete([]);

      await Future<void>.delayed(Duration.zero);

      final finalState = container.read(searchProvider);

      expect(finalState.query, 'HONDA');
      expect(finalState.errorMessage, isNull);
      expect(finalState.isSuggestionsLoading, false);
      expect(finalState.hasSearched, false);
      expect(finalState.products, isEmpty);
    },
  );
}
