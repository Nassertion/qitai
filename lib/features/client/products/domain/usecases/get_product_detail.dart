import 'package:qitai/features/client/products/domain/entities/product_detail.dart';
import 'package:qitai/features/client/products/domain/repositories/product_detail_repository.dart';

class GetProductDetail {
  final ProductDetailRepository repo;
  GetProductDetail(this.repo);

  Future<ProductDetail> call(int productId){
    return repo.getProductDetail(productId);
  }
}