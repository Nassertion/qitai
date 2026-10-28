
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:qitai/features/client/products/domain/entities/product_pagination.dart';
import 'package:qitai/features/client/products/domain/repositories/product_repository.dart';
import 'package:qitai/features/client/products/domain/usecases/get_products.dart';
import 'package:qitai/features/client/products/presentation/provider/product_provider.dart';
import 'package:qitai/features/client/search/presentation/provider/search_notifier.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_brand.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_notifier.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_state.dart';

// # Fake Products Repository
class FakeProductRepository implements ProductRepository {
  final requests = <Completer<ProductPagination>>[];
  final brandIds = <int?>[];

  @override
  Future<ProductPagination> getProducts({
    int? brandId,
    int? categoryId,
    int? modelId,
    String? query,
    String? vin,
    int? year,
    int page = 1,
  }) {
    brandIds.add(brandId);

    final request = Completer<ProductPagination>();
    requests.add(request);

    return request.future;
  }
}

// # Test Vehicle Notifier
// نغيّر فلتر السيارة بدون طلبات API حقيقية.
class TestVehicleNotifier extends VehicleNotifier {
  @override
  VehicleState build() => const VehicleState();

  void setBrandForTest(CarBrand brand) {
    state = state.copyWith(
      selectedCarBrand: brand,
    );
  }
}

// # Fake Products Response
ProductPagination fakeProductsResult({
  required int lastPage,
}) {
  return ProductPagination(
    products: [],
    currentPage: 1,
    lastPage: lastPage,
    perPage: 10,
    total: 0,
  );
}

void main() {
  // # Vehicle Filter Race Condition Test
  test(
    'Changing vehicle filter must ignore old search results',
    () async {
      // # Arrange
      final repository = FakeProductRepository();

      final container = ProviderContainer(
        overrides: [
          getProductsProvider.overrideWith(
            (ref) => GetProducts(repository),
          ),
          vehicleProvider.overrideWith(
            TestVehicleNotifier.new,
          ),
        ],
      );

      addTearDown(container.dispose);

      // # Keep Providers Alive
      final vehicleSubscription = container.listen(
        vehicleProvider,
        (_, _) {},
      );
      addTearDown(vehicleSubscription.close);

      final searchSubscription = container.listen(
        searchProvider,
        (_, _) {},
      );
      addTearDown(searchSubscription.close);

      final vehicleNotifier = container.read(
        vehicleProvider.notifier,
      ) as TestVehicleNotifier;

      final searchNotifier = container.read(
        searchProvider.notifier,
      );

      // # Set Query First
      searchNotifier.onQueryChanged('BRAKE');

      // # Select Vehicle A
      // تغيير الفلتر يشغّل البحث تلقائيًا.
      vehicleNotifier.setBrandForTest(
        const CarBrand(id: 1, name: 'Toyota'),
      );

      // # Verify Search A Started
      expect(repository.requests.length, 1);
      expect(repository.brandIds, [1]);

      // # Change To Vehicle B
      // يجب أن يبدأ بحث جديد تلقائيًا.
      vehicleNotifier.setBrandForTest(
        const CarBrand(id: 2, name: 'Honda'),
      );

      // # Verify Search B Started
      expect(repository.requests.length, 2);
      expect(repository.brandIds, [1, 2]);

      // # Complete Newer Request First
      repository.requests[1].complete(
        fakeProductsResult(lastPage: 2),
      );

      await Future<void>.delayed(Duration.zero);

      // # Verify New Results
      expect(
        container.read(searchProvider).lastPage,
        2,
      );

      expect(
        container.read(searchProvider).isProductsLoading,
        false,
      );

      // # Complete Older Request Last
      repository.requests[0].complete(
        fakeProductsResult(lastPage: 5),
      );

      await Future<void>.delayed(Duration.zero);

      // # Assert Latest Search Wins
      final state = container.read(searchProvider);

      expect(
        state.lastPage,
        2,
        reason:
            'Old vehicle results must not overwrite the latest search.',
      );

      expect(state.isProductsLoading, false);
      expect(state.errorMessage, isNull);
    },
  );
}
