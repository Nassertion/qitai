
import 'package:qitai/features/client/products/presentation/provider/product_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_product_count_provider.g.dart';

@Riverpod(keepAlive: true)
Future<int> categoryProductsCount(Ref ref, int categoryId) async {
  final getProducts = ref.watch(getProductsProvider);

  final result = await getProducts(
    categoryId: categoryId,
    page: 1,
  );

  return result.total;
}
