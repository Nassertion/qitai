import 'package:qitai/features/client/search/domain/entities/search_suggestion.dart';

abstract interface class SearchSuggestionRepository {
  Future<List<SearchSuggestion>> getSuggestions({required String query});
}
