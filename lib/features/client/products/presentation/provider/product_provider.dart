import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qitai/core/dio_provider.dart';
import 'package:qitai/features/client/products/data/model/product_detail_model.dart';
import 'package:qitai/features/client/products/data/repository/product_repostiory.dart';

final productRepositoryProvider = Provider<ProductRepostiory>((ref) {
  final dio = ref.read(dioProvider);
  return ProductRepostiory(dio);
},);

final producDetailtProvider = FutureProvider.family<ProductDetailModel,int>((ref,id) {
  final repo = ref.read(productRepositoryProvider);
  return repo.fetchProduuctDetail(id);
},);