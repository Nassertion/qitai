import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:qitai/features/client/products/domain/entities/product.dart';
import 'package:qitai/features/client/products/domain/entities/product_pagination.dart';
import 'package:qitai/features/client/products/domain/repositories/product_repository.dart';
import 'package:qitai/features/client/products/domain/usecases/get_products.dart';
import 'package:qitai/features/client/products/presentation/provider/all_products_notifier.dart';
import 'package:qitai/features/client/products/presentation/provider/product_provider.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_notifier.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_state.dart';

class FakeVehicleNotifier extends VehicleNotifier {
  @override
  VehicleState build(VehicleScope scope) {
    return const VehicleState();
  }
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
    // تهيئة أولية فورية للـ Provider
    if (requests.isEmpty) {
      final initial = Completer<ProductPagination>();
      requests.add(initial);
      initial.complete(_result(0));
      return initial.future;
    }

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

ProductPagination _result(int id) => ProductPagination(
  products: [_product(id)],
  currentPage: 1,
  lastPage: 2,
  perPage: 10,
  total: 20,
);

void main() {
  test('Old request must not overwrite newer products', () async {
    final repository = FakeProductRepository();

    final container = ProviderContainer(
      overrides: [
        getProductsProvider.overrideWith((ref) => GetProducts(repository)),
        vehicleProvider.overrideWith2((scope) => FakeVehicleNotifier()),
      ],
    );

    addTearDown(container.dispose);

    final notifier = container.read(allProductsProvider.notifier);

    // انتظار التحميل الأولي
    await Future<void>.delayed(Duration.zero);

    // بدء طلبين متداخلين
    final oldRequest = notifier.loadProducts();
    final newRequest = notifier.loadProducts();

    // الطلب الجديد ينتهي أولًا
    repository.requests[2].complete(_result(200));
    await newRequest;

    expect(container.read(allProductsProvider).products.first.id, 200);

    // الطلب القديم ينتهي لاحقًا
    repository.requests[1].complete(_result(100));
    await oldRequest;

    // لا يُسمح له باستبدال البيانات الجديدة
    final state = container.read(allProductsProvider);

    expect(state.products.first.id, 200);
    expect(state.isLoading, false);
    expect(state.errorMessage, isNull);
  });

  test('Old pagination request must not append to new products', () async {
    final repository = FakeProductRepository();

    final container = ProviderContainer(
      overrides: [
        getProductsProvider.overrideWith((ref) => GetProducts(repository)),
        vehicleProvider.overrideWith2((scope) => FakeVehicleNotifier()),
      ],
    );

    addTearDown(container.dispose);

    final notifier = container.read(allProductsProvider.notifier);

    // انتظار تنفيذ التحميل الأولي
    await Future<void>.delayed(Duration.zero);

    // الطلب الأول اكتمل ويحتوي على صفحة ثانية
    expect(container.read(allProductsProvider).hasNextPage, true);

    // بدء جلب الصفحة الثانية
    final oldPagination = notifier.loadNextPage();

    expect(container.read(allProductsProvider).isLoadingMore, true);

    // بدء تحميل منتجات جديدة قبل وصول الصفحة القديمة
    final newRequest = notifier.loadProducts();

    // استجابة الطلب الجديد تصل أولًا
    repository.requests[2].complete(_result(200));
    await newRequest;

    // استجابة الصفحة القديمة تصل متأخرة
    repository.requests[1].complete(_result(100));
    await oldPagination;

    final state = container.read(allProductsProvider);

    // يجب ألا تحتوي القائمة على منتجات الطلب القديم
    expect(state.products.map((product) => product.id).toList(), [200]);

    expect(state.currentPage, 1);
    expect(state.isLoading, false);
    expect(state.isLoadingMore, false);
    expect(state.errorMessage, isNull);
  });

  test('Old request error must not affect newer successful request', () async {
    final repository = FakeProductRepository();

    final container = ProviderContainer(
      overrides: [
        getProductsProvider.overrideWith((ref) => GetProducts(repository)),
        vehicleProvider.overrideWith2((scope) => FakeVehicleNotifier()),
      ],
    );

    addTearDown(container.dispose);

    final notifier = container.read(allProductsProvider.notifier);

    // انتظار اكتمال التحميل الأولي
    await Future<void>.delayed(Duration.zero);

    // بدء طلبين متداخلين
    final oldRequest = notifier.loadProducts();
    final newRequest = notifier.loadProducts();

    // الطلب الأحدث ينجح أولًا
    repository.requests[2].complete(_result(200));
    await newRequest;

    // الطلب القديم يفشل بعد نجاح الطلب الجديد
    repository.requests[1].completeError(Exception('Old request failed'));

    await oldRequest;

    final state = container.read(allProductsProvider);

    expect(state.products.first.id, 200);
    expect(state.errorMessage, isNull);
    expect(state.isLoading, false);
    expect(state.isLoadingMore, false);
  });
}
