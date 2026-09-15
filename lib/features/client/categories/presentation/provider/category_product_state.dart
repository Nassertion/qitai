import 'package:qitai/features/client/products/domain/entities/product.dart';

class CategoryProductState {
  final List<Product> products;
  final bool isLoading;
  final bool isLoadingMore;
  final String? errorMessage;
  final int currentPage;
  final int lastPage;

  const CategoryProductState({
    this.products = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.errorMessage,
    this.currentPage = 1,
    this.lastPage = 1,
  });

  bool get hasNextPage => currentPage < lastPage;

  CategoryProductState copyWith({
    List<Product>? products,
    bool? isLoading,
    bool? isLoadingMore,
    String? errorMessage,
    bool clearErrorMessage = false,
    int? currentPage,
    int? lastPage,
  }) {
    return CategoryProductState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: clearErrorMessage
          ? null
          : (errorMessage ?? this.errorMessage),
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
    );
  }
}