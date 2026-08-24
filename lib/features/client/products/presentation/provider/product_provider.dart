import 'package:qitai/core/network/dio_provider.dart';
import 'package:qitai/features/client/products/data/datasources/product_remote_data_source.dart';
import 'package:qitai/features/client/products/data/repository/product_repository_impl.dart';
import 'package:qitai/features/client/products/domain/repositories/product_repository.dart';
import 'package:qitai/features/client/products/domain/usecases/get_products.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_provider.g.dart';

@riverpod
ProductRemoteDataSource productRemoteDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return ProductRemoteDataSource(dio);
}

@riverpod
ProductRepository productRepository(Ref ref) {
  final dataSource = ref.watch(productRemoteDataSourceProvider);

  return ProductRepositoryImpl(dataSource);
}

@riverpod
GetProducts getProducts(Ref ref) {
  final repository = ref.watch(productRepositoryProvider);

  return GetProducts(repository);
}
