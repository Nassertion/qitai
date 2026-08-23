import 'package:qitai/features/client/products/domain/entities/product_detail.dart';

abstract interface class ProductDetailsRepository {
  Future<ProductDetail> getProductDetails(int id);
}