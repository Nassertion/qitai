import 'package:dio/dio.dart';
import 'package:qitai/core/helper/handle_helper_dio.dart';
import 'package:qitai/features/client/search/data/model/search_product_model.dart';
import 'package:qitai/features/client/search/data/model/search_suggestion_model.dart';

class SearchRepository {
  final Dio dio;

  SearchRepository(this.dio);

  Future<List<SearchSuggestionModel>> fetchSuggestions({
    required String query,
    int limit = 6,
  }) async {
    return handleDioRequest(() async {
      final response = await dio.get(
        "/products/suggest",
        queryParameters: {
          "q": query,
          "limit": limit,
        },
      );

      final List data = response.data;

      return data
          .map((item) => SearchSuggestionModel.fromJson(item as Map<String, dynamic>))
          .toList();
    });
  }

Future<List<SearchProductModel>> searchProducts({
  String? query,
  String? vin,
  int? brandId,
  int? modelId,
  int? year,
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
      },
    );

    final List data = response.data['data'] as List;

    return data
        .map((item) => SearchProductModel.fromJson(item as Map<String, dynamic>))
        .toList();
  });
}
}