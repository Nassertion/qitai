import 'package:dio/dio.dart';
import 'package:qitai/core/network/handle_helper_dio.dart';
import 'package:qitai/features/client/products/data/models/product_model.dart';
import 'package:qitai/features/client/products/data/models/product_pagination_model.dart';

class ProductRemoteDataSource {
  final Dio dio;
  ProductRemoteDataSource(this.dio);

  Future<ProductPaginationModel> getProducts({
    String? query,
    String? vin,
    int? brandId,
    int? modelId,
    int? year,
    int? categoryId,
    int page = 1,
  }) async {
    return handleDioRequest(() async {
      final response = await dio.get(
        "/products/search",
        queryParameters: {
          if (query != null && query.isNotEmpty) "q": query,
          if (vin != null && vin.isNotEmpty) "vin": vin,
          if (brandId != null) "brand_id": brandId,
          if (modelId != null) "model_id": modelId,
          if (year != null) "year": year,
          if (categoryId != null) "category_id": categoryId,
          "page": page,
        },
      );

      // final data = response.data['data'] as List<dynamic>;

         return ProductPaginationModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    });
  }}