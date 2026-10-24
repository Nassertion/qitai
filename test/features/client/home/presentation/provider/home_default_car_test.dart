
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:qitai/features/client/user/cars/domain/entities/user_car.dart';
import 'package:qitai/features/client/user/cars/domain/entities/user_car_vehicle.dart';
import 'package:qitai/features/client/user/cars/domain/entities/user_car_attribute.dart';
import 'package:qitai/features/client/user/cars/domain/repositories/user_car_repository.dart';
import 'package:qitai/features/client/user/cars/presentation/providers/user_car_provider.dart';

// # FAKE USER CAR REPOSITORY
// يحاكي الباكند ويسجل عدد الاستدعاءات.
class FakeUserCarRepository implements UserCarRepository {
  int getCarsCalls = 0;
  int setDefaultCalls = 0;

  int currentDefaultId = 1;

  @override
  Future<List<UserCar>> getUserCars() async {
    getCarsCalls++;

    return [
      _createCar(1, isDefault: currentDefaultId == 1),
      _createCar(2, isDefault: currentDefaultId == 2),
    ];
  }

  @override
  Future<UserCar> setDefaultUserCar(int id) async {
    setDefaultCalls++;
    currentDefaultId = id;

    return _createCar(id, isDefault: true);
  }

  @override
  Future<UserCar> addUserCar({
    required int brandId,
    required int modelId,
    required int yearId,
    required String vin,
    String? nickname,
    required bool isDefault,
    required List<UserCarAttributeInput> attributes,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUserCar(int id) {
    throw UnimplementedError();
  }

  // # TEST CAR DATA
  UserCar _createCar(int id, {required bool isDefault}) {
    return UserCar(
      id: id,
      userId: 1,
      vehicleId: id,
      nickname: 'Car $id',
      isDefault: isDefault,
      createdAt: null,
      updatedAt: null,
      vehicle: UserCarVehicle(
        id: id,
        brandId: id,
        modelId: id,
        yearId: id,
        vin: 'TEST-VIN-$id',
        createdAt: null,
        updatedAt: null,
        attributes: const [],
      ),
    );
  }
}

void main() {
  test(
    'Changing default car updates the cars provider after refresh',
    () async {
      // # ARRANGE
      final repository = FakeUserCarRepository();

      final container = ProviderContainer(
        overrides: [
          userCarRepositoryProvider.overrideWith(
            (ref) => repository,
          ),
        ],
      );

      addTearDown(container.dispose);

      final subscription = container.listen(
        userCarsProvider,
        (_, _) {},
      );
      addTearDown(subscription.close);

      // # INITIAL CARS
      final initialCars = await container.read(
        userCarsProvider.future,
      );

      expect(
        initialCars.singleWhere((car) => car.isDefault).id,
        1,
      );

      expect(repository.getCarsCalls, 1);

      // # CHANGE DEFAULT CAR
      final updatedCar = await container.read(
        setDefaultUserCarProvider,
      )(2);

      expect(updatedCar.id, 2);
      expect(updatedCar.isDefault, true);

      expect(repository.setDefaultCalls, 1);

      // # REFRESH USER CARS
      container.invalidate(userCarsProvider);

      final refreshedCars = await container.read(
        userCarsProvider.future,
      );

      // # ASSERTIONS
      expect(
        refreshedCars.singleWhere((car) => car.isDefault).id,
        2,
      );

      expect(repository.currentDefaultId, 2);
      expect(repository.setDefaultCalls, 1);
      expect(repository.getCarsCalls, 2);
    },
  );
}
