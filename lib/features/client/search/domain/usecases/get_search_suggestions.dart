import 'package:qitai/features/client/search/domain/entities/search_suggestion.dart';
import 'package:qitai/features/client/search/domain/repositories/search_suggestions_repository.dart';

class GetSearchSuggestions {
  final SearchSuggestionRepository repo;
  GetSearchSuggestions(this.repo);

  Future<List<SearchSuggestion>> call({required String query}) {
    return repo.getSuggestions(query: query);
  }
}
