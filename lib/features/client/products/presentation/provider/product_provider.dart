import 'package:qitai/core/network/dio_provider.dart';
import 'package:qitai/features/client/products/data/datasources/product_detail_remote_data_source.dart';
import 'package:qitai/features/client/products/data/repository/product_detail_repository_impl.dart';
import 'package:qitai/features/client/products/domain/entities/product_details.dart';
import 'package:qitai/features/client/products/domain/repositories/product_details_repository.dart';
import 'package:qitai/features/client/products/domain/usecases/get_product_details.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_provider.g.dart';

@riverpod
ProductDetailRemoteDataSource productDetailRemoteDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return ProductDetailRemoteDataSource(dio);
}

@riverpod
ProductDetailsRepository productDetailsRepository(Ref ref) {
  final dataSource = ref.watch(productDetailRemoteDataSourceProvider);

  return ProductDetailRepositoryImpl(dataSource);
}

@riverpod
GetProductDetails getProductDetails(Ref ref) {
  final repository = ref.watch(productDetailsRepositoryProvider);

  return GetProductDetails(repository);
}

@riverpod
Future<ProductDetail> productDetail(Ref ref, int productId) {
  final getProductDetails = ref.watch(getProductDetailsProvider);

  return getProductDetails(productId);
}
