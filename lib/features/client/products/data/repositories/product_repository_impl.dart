import 'package:qitai/features/client/products/data/datasources/product_remote_data_source.dart';
import 'package:qitai/features/client/products/domain/entities/product_pagination.dart';
import 'package:qitai/features/client/products/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository { 
  final ProductRemoteDataSource dataSource;
  ProductRepositoryImpl(this.dataSource);
@override
  Future<ProductPagination> getProducts({
    int? brandId,
    int? categoryId,
    int? modelId,
    String? query,
    String? vin,
    int? year,
    int page = 1
  }) async {
    final productModel = await dataSource.getProducts(
      brandId: brandId,
      categoryId: categoryId,
      modelId: modelId,
      query: query,
      vin: vin,
      year: year,page: page
    );
    return ProductPagination(
      products: productModel.products.map((product) => product.toEntity()).toList(),
      currentPage: productModel.currentPage,
      lastPage: productModel.lastPage,
      perPage: productModel.perPage,
      total: productModel.total,
    );    
  }
}