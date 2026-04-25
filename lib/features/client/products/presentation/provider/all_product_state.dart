import 'package:qitai/features/client/search/data/model/search_product_model.dart';

class AllProductsState {
  final List<SearchProductModel> products;
  final bool isLoading;
  final String? errorMessage;

  const AllProductsState({
    this.products = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  AllProductsState copyWith({
    List<SearchProductModel>? products,
    bool? isLoading,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return AllProductsState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      errorMessage:
          clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }
}