import 'package:dio/dio.dart';
import 'package:qitai/features/client/user/cars/data/models/user_car_model.dart';

class UserCarRemoteDataSource {
  final Dio dio;

  const UserCarRemoteDataSource(this.dio);

  Future<UserCarModel> addUserCar({
    required int brandId,
    required int modelId,
    required int yearId,
    required String vin,
    String? nickname,
    required bool isDefault,
    required List<Map<String, String>> attributes,
  }) async {
    final response = await dio.post(
      '/my-cars',
      data: {
        'brand_id': brandId,
        'model_id': modelId,
        'year_id': yearId,
        'vin': vin,
        'nickname': nickname,
        'is_default': isDefault,
        'attributes': attributes,
      },
    );

    return UserCarModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}