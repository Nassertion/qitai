import 'package:qitai/features/client/products/domain/entities/product.dart';
import 'package:qitai/features/client/products/domain/repositories/product_repository.dart';

class GetProducts {
  final ProductRepository repo;
  GetProducts(this.repo);

  Future<List<Product>> call({
    String? query,
    String? vin,
    int? brandId,
    int? modelId,
    int? year,
    int? categoryId,
  }) {
    return repo.getProducts(
      brandId: brandId,
      categoryId: categoryId,
      modelId: modelId,
      query: query,
      vin: vin,
      year: year,
    );
  }
}
