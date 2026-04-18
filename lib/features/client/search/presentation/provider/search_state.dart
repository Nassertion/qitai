import 'package:qitai/features/client/search/data/model/search_suggestion_model.dart';

class SearchState {
  final String query;
  final List<SearchSuggestionModel> suggestions;
  final SearchSuggestionModel? selectedSuggestion;
  final bool isLoading;
  final String? errorMessage;

  const SearchState({
    this.query = '',
    this.suggestions = const [],
    this.selectedSuggestion,
    this.isLoading = false,
    this.errorMessage,
  });

  SearchState copyWith({
    String? query,
    List<SearchSuggestionModel>? suggestions,
    SearchSuggestionModel? selectedSuggestion,
    bool? isLoading,
    String? errorMessage,
    bool clearSelectedSuggestion = false,
    bool clearErrorMessage = false,
  }) {
    return SearchState(
      query: query ?? this.query,
      suggestions: suggestions ?? this.suggestions,
      selectedSuggestion: clearSelectedSuggestion
          ? null
          : (selectedSuggestion ?? this.selectedSuggestion),
      isLoading: isLoading ?? this.isLoading,
      errorMessage:
          clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }
}