import 'package:qitai/features/client/search/data/datasources/search_suggestions_remote_data_source.dart';
import 'package:qitai/features/client/search/data/models/search_suggestion_model.dart';
import 'package:qitai/features/client/search/domain/entities/search_suggestions.dart';
import 'package:qitai/features/client/search/domain/repositories/search_suggestions_repository.dart';

class SearchSuggestionRepositoryImpl implements SearchSuggestionsRepository {
  final SearchSuggestionsRemoteDataSource dataSource;
  SearchSuggestionRepositoryImpl(this.dataSource);

  @override
  Future<List<SearchSuggestions>> getSuggestions({
    required String query,
    int? limit,
  }) async {
    final List<SearchSuggestionModel> suggestionsModel = await dataSource
        .getSuggestions(query: query);
    return suggestionsModel.map((model) => model.toEntity()).toList();
  }
}
