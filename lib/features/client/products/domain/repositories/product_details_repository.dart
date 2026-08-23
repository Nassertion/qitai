import 'package:qitai/features/client/products/domain/entities/product_details.dart';

abstract interface class ProductDetailsRepository {
  Future<ProductDetail> getProductDetails(int productId);
}