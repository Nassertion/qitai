import 'package:qitai/features/client/products/data/datasources/product_detail_remote_data_source.dart';
import 'package:qitai/features/client/products/domain/entities/product_detail.dart';
import 'package:qitai/features/client/products/domain/repositories/product_detail_repository.dart';

class ProductDetailRepositoryImpl implements ProductDetailRepository {
  final ProductDetailRemoteDataSource dataSource;
  ProductDetailRepositoryImpl(this.dataSource);

  @override
  Future<ProductDetail> getProductDetail(int productId) async {
    final productDetailModels = await dataSource
        .getProductDetail(productId);
   return productDetailModels.toEntity();

  }
}
