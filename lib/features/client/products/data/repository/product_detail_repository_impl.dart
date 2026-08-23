import 'package:qitai/features/client/products/data/datasources/product_detail_remote_data_source.dart';
import 'package:qitai/features/client/products/data/models/product_detail_model.dart';
import 'package:qitai/features/client/products/domain/entities/product_details.dart';
import 'package:qitai/features/client/products/domain/repositories/product_details_repository.dart';

class ProductDetailRepositoryImpl implements ProductDetailsRepository {
  final ProductDetailRemoteDataSource dataSource;
  ProductDetailRepositoryImpl(this.dataSource);

  @override
  Future<ProductDetail> getProductDetails(int productId) async {
    final ProductDetailModel productDetailModel = await dataSource
        .getProductDetail(productId);
    final ProductDetail productDetail = productDetailModel.toEntity();

    return productDetail;
  }
}
