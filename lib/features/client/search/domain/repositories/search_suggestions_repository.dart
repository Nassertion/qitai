import 'package:qitai/features/client/search/domain/entities/search_suggestions.dart';

abstract interface class SearchSuggestionsRepository {
  Future<List<SearchSuggestions>> getSuggestions({String query, int? limit});
}
