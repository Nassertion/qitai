import 'package:qitai/core/network/dio_provider.dart';
import 'package:qitai/features/client/products/data/model/product_detail_model.dart';
import 'package:qitai/features/client/products/data/repository/product_repository1.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_provider.g.dart';

@riverpod
ProductRepository1 productRepository(Ref ref) {
  final dio = ref.read(dioProvider);
  return ProductRepository1(dio);
}

@riverpod
Future<ProductDetailModel> productDetail(Ref ref, int id) {
  final repo = ref.read(productRepositoryProvider);
  return repo.fetchProductDetail(id);
}
