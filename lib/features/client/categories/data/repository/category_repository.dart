import 'package:dio/dio.dart';
import 'package:qitai/core/helper/handle_helper_dio.dart';
import 'package:qitai/features/client/categories/data/model/cateogry_model.dart';

class CategoryRepository {
  final Dio dio;
  CategoryRepository(this.dio);

  Future<List<CategoryModel>> fetchCategories() async {
    return handleDioRequest(() async {
      final response = await dio.get("/categories/get");
      final List data = response.data;
      return data
          .map((item) => CategoryModel.fromJson(item as Map<String, dynamic>))
          .toList();
    });
  }
}

String getCategoryIcon(String name) {
  switch (name) {
    case "الفرامل":
      return "assets/images/breaks.png";
    case "المحرك":
      return "assets/images/engine.png";
    // case "الكهرباء":
    //   return "assets/icons/electric.svg";
    // case "الزيوت والسوائل":
    //   return "assets/icons/oil.svg";
    // case "التعليق":
    //   return "assets/icons/suspension.svg";
    default:
      return "assets/images/default.png";
  }
}
