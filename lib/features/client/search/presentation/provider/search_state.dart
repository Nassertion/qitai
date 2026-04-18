import 'package:qitai/features/client/search/data/model/search_product_model.dart';
import 'package:qitai/features/client/search/data/model/search_suggestion_model.dart';

class SearchState {
  final String query;
  final List<SearchSuggestionModel> suggestions;
  final List<SearchProductModel> products;
  final bool isSuggestionsLoading;
  final bool isProductsLoading;
  final bool hasSearched;
  final String? errorMessage;

  const SearchState({
    this.query = '',
    this.suggestions = const [],
    this.products = const [],
    this.isSuggestionsLoading = false,
    this.isProductsLoading = false,
    this.hasSearched = false,
    this.errorMessage,
  });

  SearchState copyWith({
    String? query,
    List<SearchSuggestionModel>? suggestions,
    List<SearchProductModel>? products,
    bool? isSuggestionsLoading,
    bool? isProductsLoading,
    bool? hasSearched,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return SearchState(
      query: query ?? this.query,
      suggestions: suggestions ?? this.suggestions,
      products: products ?? this.products,
      isSuggestionsLoading: isSuggestionsLoading ?? this.isSuggestionsLoading,
      isProductsLoading: isProductsLoading ?? this.isProductsLoading,
      hasSearched: hasSearched ?? this.hasSearched,
      errorMessage:
          clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }
}