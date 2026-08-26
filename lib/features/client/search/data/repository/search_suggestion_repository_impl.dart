import 'package:qitai/features/client/search/data/datasources/search_suggestions_remote_data_source.dart';
import 'package:qitai/features/client/search/domain/entities/search_suggestion.dart';
import 'package:qitai/features/client/search/domain/repositories/search_suggestions_repository.dart';

class SearchSuggestionRepositoryImpl implements SearchSuggestionRepository {
  final SearchSuggestionRemoteDataSource dataSource;
  SearchSuggestionRepositoryImpl(this.dataSource);

  @override
  Future<List<SearchSuggestion>> getSuggestions({
    required String query,
    int? limit,
  }) async {
    final suggestionsModel = await dataSource
        .getSuggestions(query: query);
    return suggestionsModel.map((model) => model.toEntity()).toList();
  }
}
