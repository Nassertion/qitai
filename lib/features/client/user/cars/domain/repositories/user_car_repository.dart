import 'package:qitai/features/client/user/cars/domain/entities/user_car.dart';

abstract interface class UserCarRepository {
  Future<UserCar> addUserCar({
    required int brandId,
    required int modelId,
    required int yearId,
    required String vin,
    String? nickname,
    required bool isDefault,
    required List<Map<String, String>> attributes,
  });

  Future<List<UserCar>> getUserCars();

  Future<UserCar> setDefaultUserCar(int id);

  Future<void> deleteUserCar(int id);
}