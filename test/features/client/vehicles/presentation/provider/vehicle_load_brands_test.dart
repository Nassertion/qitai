import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:qitai/features/client/vehicles/domain/entities/car_brand.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_model.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_year.dart';
import 'package:qitai/features/client/vehicles/domain/repositories/vehicle_repository.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_provider.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_notifier.dart';

// # Fake Vehicle Repository
class FakeVehicleRepository implements VehicleRepository {
  final requests = <Completer<List<CarBrand>>>[];

  @override
  Future<List<CarBrand>> getCarBrands() {
    final request = Completer<List<CarBrand>>();
    requests.add(request);
    return request.future;
  }

  @override
  Future<List<CarModel>> getCarModels({required int brandId}) async {
    return [];
  }

  @override
  Future<List<CarYear>> getCarYears({required int modelId}) async {
    return [];
  }
}

void main() {
  
test(
  'Old brands error must not affect newer successful response',
  () async {
    // # Arrange
    final repository = FakeVehicleRepository();

    final container = ProviderContainer(
      overrides: [
        vehicleRepositoryProvider.overrideWith(
          (ref) => repository,
        ),
      ],
    );

    addTearDown(container.dispose);

    // # Keep Provider Alive
    final subscription = container.listen(
      vehicleProvider,
      (_, _) {},
    );
    addTearDown(subscription.close);

    final notifier = container.read(vehicleProvider.notifier);

    // # Start Two Requests
    final requestA = notifier.loadBrands();
    final requestB = notifier.loadBrands();

    expect(repository.requests.length, 2);

    // # New Request Succeeds
    repository.requests[1].complete([
      const CarBrand(id: 2, name: 'New Brand'),
    ]);

    await requestB;

    // # Old Request Fails Later
    repository.requests[0].completeError(
      Exception('Old network error'),
    );

    await requestA;

    // # Assert Latest State Is Preserved
    final state = container.read(vehicleProvider);

    expect(
      state.carBrands.map((brand) => brand.id).toList(),
      [2],
    );

    expect(state.isBrandsLoading, false);
    expect(state.errorMessage, isNull);
  },
);

  // # Race Condition Test
  test('Old brands response must not overwrite newer brands', () async {
    // # Arrange
    final repository = FakeVehicleRepository();

    final container = ProviderContainer(
      overrides: [vehicleRepositoryProvider.overrideWith((ref) => repository)],
    );

    addTearDown(container.dispose);

    // # Keep Provider Alive
    final subscription = container.listen(vehicleProvider, (_, _) {});

    addTearDown(subscription.close);

    final notifier = container.read(vehicleProvider.notifier);

    // # Start Request A
    final requestA = notifier.loadBrands();

    // # Start Request B
    final requestB = notifier.loadBrands();

    expect(repository.requests.length, 2);

    // # Complete Newer Request First
    repository.requests[1].complete([const CarBrand(id: 2, name: 'New Brand')]);

    await requestB;

    expect(container.read(vehicleProvider).carBrands.first.id, 2);

    // # Complete Old Request Last
    repository.requests[0].complete([const CarBrand(id: 1, name: 'Old Brand')]);

    await requestA;

    // # Assert Latest Request Wins
    final state = container.read(vehicleProvider);

    expect(state.carBrands.map((brand) => brand.id).toList(), [
      2,
    ], reason: 'The old request must not overwrite the newer result.');

    expect(state.isBrandsLoading, false);
  });
}
