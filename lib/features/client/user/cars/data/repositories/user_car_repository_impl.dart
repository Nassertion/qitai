import 'package:qitai/features/client/user/cars/data/datasources/user_car_remote_data_source.dart';
import 'package:qitai/features/client/user/cars/domain/entities/user_car.dart';
import 'package:qitai/features/client/user/cars/domain/repositories/user_car_repository.dart';

class UserCarRepositoryImpl implements UserCarRepository {
  final UserCarRemoteDataSource dataSource;

  const UserCarRepositoryImpl(this.dataSource);

  @override
  Future<UserCar> addUserCar({
    required int brandId,
    required int modelId,
    required int yearId,
    required String vin,
    String? nickname,
    required bool isDefault,
    required List<Map<String, String>> attributes,
  }) async {
    final model = await dataSource.addUserCar(
      brandId: brandId,
      modelId: modelId,
      yearId: yearId,
      vin: vin,
      nickname: nickname,
      isDefault: isDefault,
      attributes: attributes,
    );

    return model.toEntity();
  }

  @override
  Future<List<UserCar>> getUserCars() async {
    throw UnimplementedError();
  }

  @override
  Future<UserCar> setDefaultUserCar(int id) async {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUserCar(int id) async {
    throw UnimplementedError();
  }
}