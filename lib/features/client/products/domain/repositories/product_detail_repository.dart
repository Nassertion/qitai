import 'package:qitai/features/client/products/domain/entities/product_detail.dart';

abstract interface class ProductDetailRepository {
  Future<ProductDetail> getProductsDetails(int productId);
}