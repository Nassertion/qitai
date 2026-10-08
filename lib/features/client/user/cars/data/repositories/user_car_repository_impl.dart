import 'package:qitai/features/client/user/cars/data/datasources/user_car_remote_data_source.dart';
import 'package:qitai/features/client/user/cars/data/models/user_car_request_model.dart';
import 'package:qitai/features/client/user/cars/domain/entities/user_car.dart';
import 'package:qitai/features/client/user/cars/domain/entities/user_car_attribute.dart';
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
    required List<UserCarAttributeInput> attributes,
  }) async {
    final request = UserCarRequestModel(
      brandId: brandId,
      modelId: modelId,
      yearId: yearId,
      vin: vin,
      nickname: nickname,
      isDefault: isDefault,
      attributes: attributes
          .map(
            (attribute) => UserCarRequestAttributeModel(
              key: attribute.key,
              value: attribute.value,
            ),
          )
          .toList(),
    );

    final model = await dataSource.addUserCar(request);

    return model.toEntity();
  }

@override
Future<List<UserCar>> getUserCars() async {
  final models = await dataSource.getUserCars();

  return models
      .map((model) => model.toEntity())
      .toList();
}

  @override
  Future<UserCar> setDefaultUserCar(int id) async {
    throw UnimplementedError();
  }

@override
Future<void> deleteUserCar(int id) {
  return dataSource.deleteUserCar(id);
}
}