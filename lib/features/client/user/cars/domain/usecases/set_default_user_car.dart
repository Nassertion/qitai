import 'package:qitai/features/client/user/cars/domain/entities/user_car.dart';
import 'package:qitai/features/client/user/cars/domain/repositories/user_car_repository.dart';

class SetDefaultUserCar {
  final UserCarRepository repository;

  const SetDefaultUserCar(this.repository);

  Future<UserCar> call(int id) {
    return repository.setDefaultUserCar(id);
  }
}