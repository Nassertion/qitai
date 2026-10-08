import 'package:qitai/features/client/user/cars/domain/repositories/user_car_repository.dart';

class DeleteUserCar {
  final UserCarRepository repository;

  const DeleteUserCar(this.repository);

  Future<void> call(int id) {
    return repository.deleteUserCar(id);
  }
}