import 'package:dio/dio.dart';
import 'package:qitai/core/helper/handle_helper_dio.dart';
import 'package:qitai/features/client/products/data/model/product_detail_model.dart';

class ProductRepostiory {
  final Dio dio;
  ProductRepostiory(this.dio);
  Future<ProductDetailModel> fetchProduuctDetail(int id) async{
    return handleDioRequest(() async {
      final response = await dio.get("/products/${id}");
      return ProductDetailModel.fromJson(response.data as Map<String,dynamic>); 
    });
  } 
  }