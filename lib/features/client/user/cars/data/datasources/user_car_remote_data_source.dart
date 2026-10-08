import 'package:dio/dio.dart';
import 'package:qitai/core/network/handle_helper_dio.dart';
import 'package:qitai/features/client/user/cars/data/models/user_car_model.dart';
import 'package:qitai/features/client/user/cars/data/models/user_car_request_model.dart';

class UserCarRemoteDataSource {
  final Dio dio;

  const UserCarRemoteDataSource(this.dio);

Future<UserCarModel> addUserCar(
  UserCarRequestModel request,
) async {
  return handleDioRequest(() async {
    final response = await dio.post(
      '/my-cars',
      data: request.toJson(),
    );

    return UserCarModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  });
}

Future<List<UserCarModel>> getUserCars() async {
  return handleDioRequest(() async {
    final response = await dio.get('/my-cars');

    final data = response.data as List<dynamic>;

    return data
        .map(
          (item) => UserCarModel.fromJson(
            item as Map<String, dynamic>,
          ),
        )
        .toList();
  });
}
Future<UserCarModel> setDefaultUserCar(int id) async {
  return handleDioRequest(() async {
    final response = await dio.patch(
      '/my-cars/$id/set-default',
    );

    return UserCarModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  });
}
  Future<void> deleteUserCar(int id) async {
  await handleDioRequest(() async {
    await dio.delete('/my-cars/$id');
  });
}
}
