import 'package:qitai/features/client/products/domain/entities/product.dart';

abstract interface class ProductRepository {
  Future<List<Product>> getProducts({
    String? query,
    String? vin,
    int? brandId,
    int? modelId,
    int? year,
    int? categoryId,
  });
}
