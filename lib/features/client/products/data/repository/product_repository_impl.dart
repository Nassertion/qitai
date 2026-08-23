import 'package:qitai/features/client/products/data/datasources/product_remote_data_source.dart';
import 'package:qitai/features/client/products/data/models/product_model.dart';
import 'package:qitai/features/client/products/domain/entities/product.dart';
import 'package:qitai/features/client/products/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository { 
  final ProductRemoteDataSource datasource;
  ProductRepositoryImpl(this.datasource);
@override
  Future<List<Product>> getProducts({
    int? brandId,
    int? categoryId,
    int? modelId,
    String? query,
    String? vin,
    int? year,
  }) async {
    final List<ProductModel> productModel = await datasource.getProducts(
      brandId: brandId,
      categoryId: categoryId,
      modelId: modelId,
      query: query,
      vin: vin,
      year: year,
    );
    final List<Product> product = productModel.map((model) => model.toEntity()).toList();
    return product;
    
  }
}