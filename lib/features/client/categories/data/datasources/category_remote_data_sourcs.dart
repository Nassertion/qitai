import 'package:dio/dio.dart';
import 'package:qitai/core/network/handle_helper_dio.dart';
import 'package:qitai/features/client/categories/data/models/category_model.dart';

class CategoryRemoteDataSource {
  final Dio dio;
  CategoryRemoteDataSource(this.dio);

  Future<List<CategoryModel>> getCategories() async {
    return handleDioRequest(() async {
      final response = await dio.get("/categories/get");
      final List data = response.data;
      return data
          .map((item) => CategoryModel.fromJson(item as Map<String, dynamic>))
          .toList();
    });
  }
}
