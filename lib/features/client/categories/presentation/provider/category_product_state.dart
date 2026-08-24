import 'package:qitai/features/client/products/domain/entities/product.dart';

class CategorySearchState {
  final List<Product> products;
  final bool isLoading;
  final String? errorMessage;

  const CategorySearchState({
    this.products = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  CategorySearchState copyWith({
    List<Product>? products,
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