import 'package:qitai/features/client/products/data/models/product_model.dart';

class ProductPaginationModel {
  final List<ProductModel> products;
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  const ProductPaginationModel({
    required this.products,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory ProductPaginationModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as List<dynamic>;
    final meta = json['meta'] as Map<String, dynamic>;

    return ProductPaginationModel(
      products: data
          .map(
            (item) => ProductModel.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(),
      currentPage: meta['current_page'] as int,
      lastPage: meta['last_page'] as int,
      perPage: meta['per_page'] as int,
      total: meta['total'] as int,
    );
  }
}