import 'package:qitai/features/client/products/domain/entities/product.dart';
import 'package:qitai/features/client/search/domain/entities/search_suggestion.dart';

class SearchState {
  final String query;
  final List<SearchSuggestion> suggestions;
  final List<Product> products;
  final bool isSuggestionsLoading;
  final bool isProductsLoading;
  final bool isLoadingMore;
  final bool hasSearched;
  final String? errorMessage;
  // final int? categoryId;
  final int currentPage;
  final int lastPage;

  const SearchState({
    this.query = '',
    this.suggestions = const [],
    this.products = const [],
    this.isSuggestionsLoading = false,
    this.isProductsLoading = false,
    this.isLoadingMore = false,
    this.hasSearched = false,
    this.errorMessage,
    // this.categoryId,
    this.currentPage = 1,
    this.lastPage = 1,
  });

  bool get hasNextPage => currentPage < lastPage;

  SearchState copyWith({
    String? query,
    List<SearchSuggestion>? suggestions,
    List<Product>? products,
    bool? isSuggestionsLoading,
    bool? isProductsLoading,
    bool? isLoadingMore,
    bool? hasSearched,
    String? errorMessage,
    bool clearErrorMessage = false,
    int? categoryId,
    int? currentPage,
    int? lastPage,
  }) {
    return SearchState(
      query: query ?? this.query,
      suggestions: suggestions ?? this.suggestions,
      products: products ?? this.products,
      isSuggestionsLoading:
          isSuggestionsLoading ?? this.isSuggestionsLoading,
      isProductsLoading: isProductsLoading ?? this.isProductsLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasSearched: hasSearched ?? this.hasSearched,
      errorMessage: clearErrorMessage
          ? null
          : (errorMessage ?? this.errorMessage),
      // categoryId: categoryId ?? this.categoryId,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
    );
  }
}