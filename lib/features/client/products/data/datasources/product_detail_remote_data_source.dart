import 'package:dio/dio.dart';
import 'package:qitai/core/network/handle_helper_dio.dart';
import 'package:qitai/features/client/products/data/models/product_detail_model.dart';

class ProductDetailRemoteDataSource{
  final Dio dio;

  ProductDetailRemoteDataSource(this.dio);

  Future<ProductDetailModel> getProductDetail(int id) async {
    return handleDioRequest(() async {
      final response = await dio.get("/products/$id");
      return ProductDetailModel.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
    });
  }
}
