import 'package:dio/dio.dart';
import 'package:qitai/core/network/handle_helper_dio.dart';
import 'package:qitai/features/client/products/data/model/product_detail_model.dart';

class ProductRepository1 {
  final Dio dio;

  ProductRepository1(this.dio);

  Future<ProductDetailModel> fetchProductDetail(int id) async {
    return handleDioRequest(() async {
      final response = await dio.get("/products/$id");
      return ProductDetailModel.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
    });
  }
}
