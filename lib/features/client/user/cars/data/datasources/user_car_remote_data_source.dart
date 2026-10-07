import 'package:dio/dio.dart';
import 'package:qitai/features/client/user/cars/data/models/user_car_model.dart';
import 'package:qitai/features/client/user/cars/data/models/user_car_request_model.dart';

class UserCarRemoteDataSource {
  final Dio dio;

  const UserCarRemoteDataSource(this.dio);

  Future<UserCarModel> addUserCar(
    UserCarRequestModel request,
  ) async {
    final response = await dio.post(
      '/my-cars',
      data: request.toJson(),
    );

    return UserCarModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}