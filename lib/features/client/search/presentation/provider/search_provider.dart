import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qitai/core/network/dio_provider.dart';
import 'package:qitai/features/client/search/data/repository/search_repository.dart';
import 'package:qitai/features/client/search/presentation/provider/search_notifier.dart';
import 'package:qitai/features/client/search/presentation/provider/search_state.dart';

final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  final dio = ref.read(dioProvider);
  return SearchRepository(dio);
});

final searchProvider = NotifierProvider.autoDispose<SearchNotifier, SearchState>(
  SearchNotifier.new,
);