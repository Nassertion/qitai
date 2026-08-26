import 'package:dio/dio.dart';
import 'package:qitai/core/network/handle_helper_dio.dart';
import 'package:qitai/features/client/vehicles/data/model/vehicles_model1.dart';

class VehicleRepository1 {
  final Dio dio;

  VehicleRepository1(this.dio);

  Future<List<CarBrand1>> fetchCarBrands() async {
    return handleDioRequest(() async {
      final response = await dio.get("/vehicles/brands");
      final List data = response.data;

      return data
          .map((item) => CarBrand1.fromJson(item as Map<String, dynamic>))
          .toList();
    });
  }

  Future<List<CarModel1>> fetchCarModels(int brandId) async {
    return handleDioRequest(() async {
      final response = await dio.get(
        "/vehicles/models",
        queryParameters: {"brand_id": brandId},
      );

      final List data = response.data;

      return data
          .map((item) => CarModel1.fromJson(item as Map<String, dynamic>))
          .toList();
    });
  }

  Future<List<CarYear1>> fetchCarYears(int modelId) async {
    return handleDioRequest(() async {
      final response = await dio.get(
        "/vehicles/years",
        queryParameters: {"model_id": modelId},
      );

      final List data = response.data;

      return data
          .map((item) => CarYear1.fromJson(item as Map<String, dynamic>))
          .toList();
    });
  }
}