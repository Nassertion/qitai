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

// temp only
String getCategoryIcon(String name) {
  switch (name) {
    case "الفرامل":
      return "assets/images/breaks.png";
    case "المحرك":
      return "assets/images/engine.png";
    case "الكهرباء":
      return "assets/images/boaji.png";
    case "الزيوت والسوائل":
      return "assets/images/oils.png";
    case "التعليق":
      return "assets/images/t3le8.png";
    default:
      return "assets/images/default.png";
  }
}

String getIcon(String name) {
  switch (name) {
    case "الفرامل":
      return "assets/images/cate/breaks.png";
    case "المحرك":
      return "assets/images/cate/test30.png";
    case "الكهرباء":
      return "assets/images/cate/boaji.png";
    case "الزيوت والسوائل":
      return "assets/images/cate/oils.png";
    case "التعليق":
      return "assets/images/cate/t3le8.png";
    default:
      return "assets/images/cate/default.png";
  }
}

// String test(String name) {
//   switch (name) {
//     case "الفرامل":
//       return "assets/icons/test40.svg";
//     case "المحرك":
//       return "assets/images/test30.";
//     // case "الكهرباء":
//     //   return "assets/images/boaji.png";
//     // case "الزيوت والسوائل":
//     //   return "assets/images/oils.png";
//     // case "التعليق":
//     //   return "assets/images/t3le8.png";
//     default:
//       return "assets/icons/def.svg";
//   }
// }
