import 'package:qitai/features/client/search/data/model/search_product_model.dart';

class CategorySearchState {
  final List<SearchProductModel> products;
  final bool isLoading;
  final String? errorMessage;

  const CategorySearchState({
    this.products = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  CategorySearchState copyWith({
    List<SearchProductModel>? products,
    bool? isLoading,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return CategorySearchState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }
}