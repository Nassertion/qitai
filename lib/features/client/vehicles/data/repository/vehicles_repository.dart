import 'package:dio/dio.dart';
import 'package:qitai/core/network/handle_helper_dio.dart';
import 'package:qitai/features/client/vehicles/data/model/vehicles_model.dart';

class ClassificationRepository {
  final Dio dio;

  ClassificationRepository(this.dio);

  Future<List<CarBrand>> fetchCarBrands() async {
    return handleDioRequest(() async {
      final response = await dio.get("/vehicles/brands");
      final List data = response.data;

      return data
          .map((item) => CarBrand.fromJson(item as Map<String, dynamic>))
          .toList();
    });
  }

  Future<List<CarModel>> fetchCarModels(int brandId) async {
    return handleDioRequest(() async {
      final response = await dio.get(
        "/vehicles/models",
        queryParameters: {"brand_id": brandId},
      );

      final List data = response.data;

      return data
          .map((item) => CarModel.fromJson(item as Map<String, dynamic>))
          .toList();
    });
  }

  Future<List<CarYear>> fetchCarYears(int modelId) async {
    return handleDioRequest(() async {
      final response = await dio.get(
        "/vehicles/years",
        queryParameters: {"model_id": modelId},
      );

      final List data = response.data;

      return data
          .map((item) => CarYear.fromJson(item as Map<String, dynamic>))
          .toList();
    });
  }
}