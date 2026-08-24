import 'package:qitai/features/client/products/domain/entities/product.dart';

class AllProductsState {
  final List<Product> products;
  final bool isLoading;
  final String? errorMessage;

  const AllProductsState({
    this.products = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  AllProductsState copyWith({
    List<Product>? products,
    bool? isLoading,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return AllProductsState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearErrorMessage
          ? null
          : (errorMessage ?? this.errorMessage),
    );
  }
}
