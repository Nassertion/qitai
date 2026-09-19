import 'package:qitai/features/client/products/domain/entities/product_detail.dart';
import 'package:qitai/features/client/products/domain/repositories/product_detail_repository.dart';

class GetProductsDetails {
  final ProductDetailRepository repo;
  GetProductsDetails(this.repo);

  Future<ProductDetail> call(int productId){
    return repo.getProductsDetails(productId);
  }
}