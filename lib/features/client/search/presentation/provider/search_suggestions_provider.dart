import 'package:qitai/core/network/dio_provider.dart';
import 'package:qitai/features/client/search/data/datasources/search_suggestions_remote_data_source.dart';
import 'package:qitai/features/client/search/data/repository/search_suggestion_repository_impl.dart';
import 'package:qitai/features/client/search/domain/repositories/search_suggestions_repository.dart';
import 'package:qitai/features/client/search/domain/usecases/get_search_suggestions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_suggestions_provider.g.dart';

@riverpod
SearchSuggestionRemoteDataSource searchSuggestionRemoteDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return SearchSuggestionRemoteDataSource(dio);
}

@riverpod
SearchSuggestionRepository searchSuggestionRepository(Ref ref) {
  final datasource = ref.watch(searchSuggestionRemoteDataSourceProvider);
  return SearchSuggestionRepositoryImpl(datasource);
}

@riverpod
GetSearchSuggestions getSearchSuggestions(Ref ref) {
  final repository = ref.watch(searchSuggestionRepositoryProvider);
  return GetSearchSuggestions(repository);
}
