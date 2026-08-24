import 'package:qitai/features/client/search/domain/entities/search_suggestions.dart';
import 'package:qitai/features/client/search/domain/repositories/search_suggestions_repository.dart';

class GetSuggestions {
  final SearchSuggestionsRepository repo;
  GetSuggestions(this.repo);

  Future<List<SearchSuggestions>> call({
    required String query , int ?limit

  }){
    return repo.getSuggestions(query: query,limit: limit);
  }
  
}