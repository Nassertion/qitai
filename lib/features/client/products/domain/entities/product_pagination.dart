import 'package:qitai/features/client/products/domain/entities/product.dart';

class ProductPagination {
  final List<Product> products;
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  const ProductPagination({
    required this.products,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  bool get hasNextPage => currentPage < lastPage;
}