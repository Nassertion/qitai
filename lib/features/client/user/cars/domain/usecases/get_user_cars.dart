import 'package:qitai/features/client/user/cars/domain/entities/user_car.dart';
import 'package:qitai/features/client/user/cars/domain/repositories/user_car_repository.dart';

class GetUserCars {
  final UserCarRepository repository;

  const GetUserCars(this.repository);

  Future<List<UserCar>> call() {
    return repository.getUserCars();
  }
}