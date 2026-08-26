import 'package:dio/dio.dart';
import 'package:qitai/core/network/handle_helper_dio.dart';
import 'package:qitai/features/client/search/data/models/search_suggestion_model.dart';

class SearchSuggestionRemoteDataSource {
  final Dio dio;
  SearchSuggestionRemoteDataSource(this.dio);

  Future<List<SearchSuggestionModel>> getSuggestions({
    required String query,
    int limit = 6,
  }) async {
    return handleDioRequest(() async {
      final response = await dio.get(
        "/products/suggest",
        queryParameters: {"q": query, "limit": limit},
      );

      final List data = response.data;

      return data
          .map(
            (item) =>
                SearchSuggestionModel.fromJson(item as Map<String, dynamic>),
          )
          .toList();
    });
  }
}
