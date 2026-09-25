import 'dart:math';

import 'package:qitai/features/client/products/domain/entities/product.dart';
import 'package:qitai/features/client/products/presentation/provider/product_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'similar_products_provider.g.dart';

@riverpod
Future<List<Product>> similarProducts(
  Ref ref,
  int currentProductId,
) async {
  final getProducts = ref.read(getProductsProvider);

  final result = await getProducts(
    page: 1,
  );

  final products = result.products
      .where((product) => product.id != currentProductId)
      .toList();

  products.shuffle(Random());

  return products.take(10).toList();
}