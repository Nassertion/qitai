import 'package:qitai/features/client/products/domain/entities/product_pagination.dart';

abstract interface class ProductRepository {
  Future<ProductPagination> getProducts({
    String? query,
    String? vin,
    int? brandId,
    int? modelId,
    int? year,
    int? categoryId,
    int page = 1,
  });
}
