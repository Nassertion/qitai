import 'package:qitai/core/network/dio_provider.dart';
import 'package:qitai/features/client/search/data/datasources/search_suggestions_remote_data_source.dart';
import 'package:qitai/features/client/search/data/repository/search_suggestion_repository_impl.dart';
import 'package:qitai/features/client/search/domain/repositories/search_suggestions_repository.dart';
import 'package:qitai/features/client/search/domain/usecases/search_suggestions_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_sugesstions_provider.g.dart';

@riverpod 
SearchSuggestionsRemoteDataSource searchSuggestionsRemoteDataSource(Ref ref){
  final dio = ref.watch(dioProvider);
  return SearchSuggestionsRemoteDataSource(dio);
}
@riverpod
SearchSuggestionsRepository searchSuggestionsRepository(Ref ref){
  final datasource = ref.watch(searchSuggestionsRemoteDataSourceProvider);
  return SearchSuggestionRepositoryImpl(datasource);
} 
@riverpod
GetSuggestions getSuggestions(Ref ref){
  final repo = ref.watch(searchSuggestionsRepositoryProvider);
  return GetSuggestions(repo);
}
// @riverpod
// Future<List<SearchSuggestions>> searchSuggestions(Ref ref , String query , int limit ){
//   final getSearchSuggestions = ref.watch(getSuggestionsProvider);
//   return getSearchSuggestions(query: query,limit: limit);
// }