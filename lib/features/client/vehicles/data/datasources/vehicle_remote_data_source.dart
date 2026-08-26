import 'package:dio/dio.dart';
import 'package:qitai/core/network/handle_helper_dio.dart';
import 'package:qitai/features/client/vehicles/data/model/car_brand_model.dart';
import 'package:qitai/features/client/vehicles/data/model/car_model_model.dart';
import 'package:qitai/features/client/vehicles/data/model/car_year_model.dart';

class VehicleRemoteDataSource {
  final Dio dio;

  VehicleRemoteDataSource(this.dio);

  Future<List<CarBrandModel>> getCarBrands() async {
    return handleDioRequest(() async {
      final response = await dio.get("/vehicles/brands");
      final List data = response.data;

      return data
          .map((item) => CarBrandModel.fromJson(item as Map<String, dynamic>))
          .toList();
    });
  }

  Future<List<CarModelModel>> getCarModels(int brandId) async {
    return handleDioRequest(() async {
      final response = await dio.get(
        "/vehicles/models",
        queryParameters: {"brand_id": brandId},
      );

      final List data = response.data;

      return data
          .map((item) => CarModelModel.fromJson(item as Map<String, dynamic>))
          .toList();
    });
  }

  Future<List<CarYearModel>> getCarYears(int modelId) async {
    return handleDioRequest(() async {
      final response = await dio.get(
        "/vehicles/years",
        queryParameters: {"model_id": modelId},
      );

      final List data = response.data;

      return data
          .map((item) => CarYearModel.fromJson(item as Map<String, dynamic>))
          .toList();
    });
  }
}