import 'package:qitai/features/client/products/domain/entities/product_pagination.dart';
import 'package:qitai/features/client/products/domain/repositories/product_repository.dart';

class GetProducts {
  final ProductRepository repo;
  GetProducts(this.repo);

  Future<ProductPagination> call({
    String? query,
    String? vin,
    int? brandId,
    int? modelId,
    int? year,
    int? categoryId,
    int page = 1 
  }) {
    return repo.getProducts(
      brandId: brandId,
      categoryId: categoryId,
      modelId: modelId,
      query: query,
      vin: vin,
      year: year,
      page: page
    );
  }
}
