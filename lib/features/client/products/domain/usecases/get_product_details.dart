import 'package:qitai/features/client/products/domain/entities/product_details.dart';
import 'package:qitai/features/client/products/domain/repositories/product_details_repository.dart';

class GetProductDetails {
  final ProductDetailsRepository repo;
  GetProductDetails(this.repo);

  Future<ProductDetail> call(int productId){
    return repo.getProductDetails(productId);
  }
}