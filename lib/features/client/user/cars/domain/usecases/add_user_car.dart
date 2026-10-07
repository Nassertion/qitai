import 'package:qitai/features/client/user/cars/domain/entities/user_car.dart';
import 'package:qitai/features/client/user/cars/domain/repositories/user_car_repository.dart';

class AddUserCar {
  final UserCarRepository repository;

  const AddUserCar(this.repository);

  Future<UserCar> call({
    required int brandId,
    required int modelId,
    required int yearId,
    required String vin,
    String? nickname,
    required bool isDefault,
    required List<Map<String, String>> attributes,
  }) {
    return repository.addUserCar(
      brandId: brandId,
      modelId: modelId,
      yearId: yearId,
      vin: vin,
      nickname: nickname,
      isDefault: isDefault,
      attributes: attributes,
    );
  }
}