import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qitai/features/client/products/presentation/provider/product_provider.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_product_count_provider.g.dart';

@Riverpod(keepAlive: true)
Future<int> categoryProductsCount(Ref ref, int categoryId) async {
  final brandId = ref.watch(
    vehicleProvider(VehicleScope.browse).select((s) => s.selectedCarBrand?.id),
  );
  final modelId = ref.watch(
    vehicleProvider(VehicleScope.browse).select((s) => s.selectedModel?.id),
  );
  final year = ref.watch(
    vehicleProvider(VehicleScope.browse).select((s) => s.selectedCarYear?.year),
  );

  final getProducts = ref.watch(getProductsProvider);

  final result = await getProducts(
    brandId: brandId,
    modelId: modelId,
    year: year,
    categoryId: categoryId,
    page: 1,
  );

  return result.total;
}
