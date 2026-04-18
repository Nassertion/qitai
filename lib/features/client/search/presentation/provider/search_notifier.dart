import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qitai/features/client/search/data/model/search_suggestion_model.dart';
import 'package:qitai/features/client/search/data/repository/search_repository.dart';
import 'package:qitai/features/client/search/presentation/provider/search_provider.dart';
import 'package:qitai/features/client/search/presentation/provider/search_state.dart';

class SearchNotifier extends Notifier<SearchState> {
  late final SearchRepository repo;
  Timer? _debounce;

  @override
  SearchState build() {
    repo = ref.read(searchRepositoryProvider);
    ref.onDispose(() {
      _debounce?.cancel();
    });
    return const SearchState();
  }

void onQueryChanged(String value) {
  final query = value.trim();

  state = state.copyWith(
    query: value,
    clearSelectedSuggestion: true,
    clearErrorMessage: true,
  );

  _debounce?.cancel();

  if (query.isEmpty) {
    state = state.copyWith(
      suggestions: [],
      isLoading: false,
    );
    return;
  }

  _debounce = Timer(const Duration(milliseconds: 300), () {
    loadSuggestions(query);
  });
}

  Future<void> loadSuggestions(String query) async {
    state = state.copyWith(
      isLoading: true,
      clearErrorMessage: true,
    );

    try {
      final suggestions = await repo.fetchSuggestions(query: query);

      if (state.query.trim() != query) return;

      state = state.copyWith(
        suggestions: suggestions,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }
  void selectSuggestion(SearchSuggestionModel item) {
  state = state.copyWith(
    query: item.name,
    selectedSuggestion: item,
    suggestions: [],
    isLoading: false,
    clearErrorMessage: true,
  );
}

  void clearSearch() {
    _debounce?.cancel();
    state = state.copyWith(
      query: '',
      suggestions: [],
      isLoading: false,
      clearErrorMessage: true,
    );
  }
}