
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
    final request = Completer<ProductPagination>();
    requests.add(request);
    return request.future;
  }
}

ProductPagination result(int id) => ProductPagination(
  products: [
    Product(
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
    ),
  ],
  currentPage: 1,
  lastPage: 2,
  perPage: 10,
  total: 20,
);

void main() {
  test('Old request must not overwrite newer category products', () async {
    final repository = FakeProductRepository();

    final container = ProviderContainer(
      overrides: [
        getProductsProvider.overrideWith(
          (ref) => GetProducts(repository),
        ),
        vehicleProvider.overrideWith(FakeVehicleNotifier.new),
      ],
    );

    addTearDown(container.dispose);

    final provider = categoryProductProvider(5);

    // Keep the autoDispose provider alive during the test.
    final subscription = container.listen(provider, (_, _) {});
    addTearDown(subscription.close);

    final notifier = container.read(provider.notifier);

    // The notifier starts its initial request automatically.
    await Future<void>.delayed(Duration.zero);

    expect(repository.requests.length, 1);

    // Finish the initial request.
    repository.requests[0].complete(result(0));
    await Future<void>.delayed(Duration.zero);

    // Start two overlapping requests.
    final oldRequest = notifier.loadProducts();
    final newRequest = notifier.loadProducts();

    expect(repository.requests.length, 3);

    // The newer request finishes first.
    repository.requests[2].complete(result(200));
    await newRequest;

    expect(container.read(provider).products.first.id, 200);

    // The older request finishes later.
    repository.requests[1].complete(result(100));
    await oldRequest;

    // Expected behavior: retain the newer results.
    expect(container.read(provider).products.first.id, 200);
  });
}
