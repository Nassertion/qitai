import 'package:qitai/features/client/products/domain/entities/product.dart';
import 'package:qitai/features/client/search/domain/entities/search_suggestion.dart';

class SearchState {
  final String query;
  final List<SearchSuggestion> suggestions;
  final List<Product> products;
  final bool isSuggestionsLoading;
  final bool isProductsLoading;
  final bool hasSearched;
  final String? errorMessage;
  final int? categoryId;

  const SearchState({
    this.query = '',
    this.suggestions = const [],
    this.products = const [],
    this.isSuggestionsLoading = false,
    this.isProductsLoading = false,
    this.hasSearched = false,
    this.errorMessage,
    this.categoryId,
  });

  SearchState copyWith({
    String? query,
    List<SearchSuggestion>? suggestions,
    List<Product>? products,
    bool? isSuggestionsLoading,
    bool? isProductsLoading,
    bool? hasSearched,
    String? errorMessage,
    bool clearErrorMessage = false,
    int? categoryId,
  }) {
    return SearchState(
      query: query ?? this.query,
      suggestions: suggestions ?? this.suggestions,
      products: products ?? this.products,
      isSuggestionsLoading: isSuggestionsLoading ?? this.isSuggestionsLoading,
      isProductsLoading: isProductsLoading ?? this.isProductsLoading,
      hasSearched: hasSearched ?? this.hasSearched,
      errorMessage: clearErrorMessage
          ? null
          : (errorMessage ?? this.errorMessage),
      categoryId: categoryId ?? this.categoryId,
    );
  }
}
