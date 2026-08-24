import 'package:qitai/features/client/products/domain/entities/product.dart';

class CategoryProductState {
  final List<Product> products;
  final bool isLoading;
  final String? errorMessage;

  const CategoryProductState({
    this.products = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  CategoryProductState copyWith({
    List<Product>? products,
    bool? isLoading,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return CategoryProductState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }
}