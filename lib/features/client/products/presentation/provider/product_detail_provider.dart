import 'package:qitai/core/network/dio_provider.dart';
import 'package:qitai/features/client/products/data/datasources/product_detail_remote_data_source.dart';
import 'package:qitai/features/client/products/data/repositories/product_detail_repository_impl.dart';
import 'package:qitai/features/client/products/domain/entities/product_detail.dart';
import 'package:qitai/features/client/products/domain/repositories/product_detail_repository.dart';
import 'package:qitai/features/client/products/domain/usecases/get_product_detail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_detail_provider.g.dart';

@riverpod
ProductDetailRemoteDataSource productDetailRemoteDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return ProductDetailRemoteDataSource(dio);
}

@riverpod
ProductDetailRepository productDetailRepository(Ref ref) {
  final dataSource = ref.watch(productDetailRemoteDataSourceProvider);

  return ProductDetailRepositoryImpl(dataSource);
}

@riverpod
GetProductDetail getProductDetail(Ref ref) {
  final repository = ref.watch(productDetailRepositoryProvider);

  return GetProductDetail(repository);
}

@riverpod
Future<ProductDetail> productDetail(Ref ref, int productId) {
  final getProductDetail = ref.watch(getProductDetailProvider);

  return getProductDetail(productId);
}
