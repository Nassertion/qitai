import 'package:dio/dio.dart';
import 'package:qitai/core/helper/handle_helper_dio.dart';
import 'package:qitai/features/client/classification/data/model/classification_model.dart';

class ClassificationRepository {
  final Dio dio;

  ClassificationRepository(this.dio);

  Future<List<CarBrand>> fetchCarBrands() async {
    return handleDioRequest(() async {
      final response = await dio.get("/vehicles/CarBrands");
      final List data = response.data;

      return data
          .map((item) => CarBrand.fromJson(item as Map<String, dynamic>))
          .toList();
    });
  }

  Future<List<CarModel>> fetchCarModels(int carBrandId) async {
    return handleDioRequest(() async {
      final response = await dio.get(
        "/vehicles/models",
        queryParameters: {"CarBrand_id": carBrandId},
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
        "/vehicles/CarYears",
        queryParameters: {"model_id": modelId},
      );

      final List data = response.data;

      return data
          .map((item) => CarYear.fromJson(item as Map<String, dynamic>))
          .toList();
    });
  }
}