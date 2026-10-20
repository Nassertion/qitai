
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:qitai/features/client/categories/presentation/provider/category_product_notifier.dart';
import 'package:qitai/features/client/products/domain/entities/product.dart';
import 'package:qitai/features/client/products/domain/entities/product_pagination.dart';
import 'package:qitai/features/client/products/domain/repositories/product_repository.dart';
import 'package:qitai/features/client/products/domain/usecases/get_products.dart';
import 'package:qitai/features/client/products/presentation/provider/product_provider.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_notifier.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_state.dart';

class FakeVehicleNotifier extends VehicleNotifier {
  @override
  VehicleState build() => const VehicleState();
}

class FakeProductRepository implements ProductRepository {
  final requests = <Completer<ProductPagination>>[];
  final requestedPages = <int>[];

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
    requestedPages.add(page);

    final request = Completer<ProductPagination>();
    requests.add(request);

    return request.future;
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
}) => ProductPagination(
  products: [_product(id)],
  currentPage: page,
  lastPage: 2,
  perPage: 10,
  total: 20,
);

void main() {
  test(
    'Old request must not overwrite newer category products',
    () async {
      final repository = FakeProductRepository();

      final container = ProviderContainer(
        overrides: [
          getProductsProvider.overrideWith(
            (ref) => GetProducts(repository),
          ),
          vehicleProvider.overrideWith(
            FakeVehicleNotifier.new,
          ),
        ],
      );

      addTearDown(container.dispose);

      final provider = categoryProductProvider(5);

      final subscription = container.listen(
        provider,
        (_, _) {},
      );

      addTearDown(subscription.close);

      final notifier = container.read(provider.notifier);

      await Future<void>.delayed(Duration.zero);

      expect(repository.requests.length, 1);

      repository.requests[0].complete(_result(0));
      await Future<void>.delayed(Duration.zero);

      final oldRequest = notifier.loadProducts();
      final newRequest = notifier.loadProducts();

      expect(repository.requests.length, 3);

      repository.requests[2].complete(_result(200));
      await newRequest;

      expect(
        container.read(provider).products.first.id,
        200,
      );

      repository.requests[1].complete(_result(100));
      await oldRequest;

      final state = container.read(provider);

      expect(state.products.first.id, 200);
      expect(state.isLoading, false);
      expect(state.errorMessage, isNull);
    },
  );

  test(
    'Old pagination must not append products after a new load',
    () async {
      final repository = FakeProductRepository();

      final container = ProviderContainer(
        overrides: [
          getProductsProvider.overrideWith(
            (ref) => GetProducts(repository),
          ),
          vehicleProvider.overrideWith(
            FakeVehicleNotifier.new,
          ),
        ],
      );

      addTearDown(container.dispose);

      final provider = categoryProductProvider(5);

      final subscription = container.listen(
        provider,
        (_, _) {},
      );

      addTearDown(subscription.close);

      final notifier = container.read(provider.notifier);

      await Future<void>.delayed(Duration.zero);

      expect(repository.requests.length, 1);

      repository.requests[0].complete(_result(10));
      await Future<void>.delayed(Duration.zero);

      expect(container.read(provider).hasNextPage, true);

      final oldPagination = notifier.loadNextPage();

      expect(repository.requests.length, 2);
      expect(repository.requestedPages[1], 2);
      expect(container.read(provider).isLoadingMore, true);

      final newRequest = notifier.loadProducts();

      expect(repository.requests.length, 3);
      expect(repository.requestedPages[2], 1);

      repository.requests[2].complete(_result(200));
      await newRequest;

      expect(
        container.read(provider).products
            .map((product) => product.id)
            .toList(),
        [200],
      );

      repository.requests[1].complete(
        _result(100, page: 2),
      );
      await oldPagination;

      final state = container.read(provider);

      expect(
        state.products.map((product) => product.id).toList(),
        [200],
      );
      expect(state.currentPage, 1);
      expect(state.isLoading, false);
      expect(state.isLoadingMore, false);
      expect(state.errorMessage, isNull);
    },
  );

  test(
    'Old request error must not affect newer successful results',
    () async {
      final repository = FakeProductRepository();

      final container = ProviderContainer(
        overrides: [
          getProductsProvider.overrideWith(
            (ref) => GetProducts(repository),
          ),
          vehicleProvider.overrideWith(
            FakeVehicleNotifier.new,
          ),
        ],
      );

      addTearDown(container.dispose);

      final provider = categoryProductProvider(5);

      final subscription = container.listen(
        provider,
        (_, _) {},
      );

      addTearDown(subscription.close);

      final notifier = container.read(provider.notifier);

      // Complete the initial request.
      await Future<void>.delayed(Duration.zero);

      expect(repository.requests.length, 1);

      repository.requests[0].complete(_result(0));
      await Future<void>.delayed(Duration.zero);

      // Start two overlapping requests.
      final oldRequest = notifier.loadProducts();
      final newRequest = notifier.loadProducts();

      expect(repository.requests.length, 3);

      // The newer request succeeds first.
      repository.requests[2].complete(_result(200));
      await newRequest;

      expect(
        container.read(provider).products.first.id,
        200,
      );

      // The older request fails after the newer success.
      repository.requests[1].completeError(
        Exception('Old request failed'),
      );

      await oldRequest;

      final state = container.read(provider);

      expect(state.products.first.id, 200);
      expect(state.errorMessage, isNull);
      expect(state.isLoading, false);
      expect(state.isLoadingMore, false);
    },
  );
}
