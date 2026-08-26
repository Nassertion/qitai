import 'package:qitai/features/client/products/data/datasources/product_remote_data_source.dart';
import 'package:qitai/features/client/products/domain/entities/product.dart';
import 'package:qitai/features/client/products/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository { 
  final ProductRemoteDataSource dataSource;
  ProductRepositoryImpl(this.dataSource);
@override
  Future<List<Product>> getProducts({
    int? brandId,
    int? categoryId,
    int? modelId,
    String? query,
    String? vin,
    int? year,
  }) async {
    final productModels = await dataSource.getProducts(
      brandId: brandId,
      categoryId: categoryId,
      modelId: modelId,
      query: query,
      vin: vin,
      year: year,
    );
    return productModels.map((model) => model.toEntity()).toList();
    
  }
}