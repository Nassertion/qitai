import 'package:qitai/features/client/categories/presentation/provider/category_product_state.dart';
import 'package:qitai/features/client/products/domain/usecases/get_products.dart';
import 'package:qitai/features/client/products/presentation/provider/product_provider.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicles_notifier.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicles_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_product_notifier.g.dart';

@riverpod
class CategoryProductNotifier extends _$CategoryProductNotifier {
  late final GetProducts getProducts;
  late final int _categoryId;

  @override
  CategoryProductState build(int categoryId) {
    getProducts = ref.read(getProductsProvider);
    _categoryId = categoryId;

    ref.listen<VehicleState>(vehicleProvider, (previous, next) {
      final prevBrandId = previous?.selectedCarBrand?.id;
      final nextBrandId = next.selectedCarBrand?.id;

      final prevModelId = previous?.selectedModel?.id;
      final nextModelId = next.selectedModel?.id;

      final prevYear = previous?.selectedCarYear?.year;
      final nextYear = next.selectedCarYear?.year;

      final filtersChanged =
          prevBrandId != nextBrandId ||
          prevModelId != nextModelId ||
          prevYear != nextYear;

      if (!filtersChanged) return;

      loadProducts();
    });

    Future.microtask(() => loadProducts());

    return const CategoryProductState();
  }

  Future<void> loadProducts() async {
    final vehicleState = ref.read(vehicleProvider);

    final brandId = vehicleState.selectedCarBrand?.id;
    final modelId = vehicleState.selectedModel?.id;
    final year = vehicleState.selectedCarYear?.year;

    state = state.copyWith(isLoading: true, clearErrorMessage: true);

    try {
      final products = await getProducts(
        brandId: brandId,
        modelId: modelId,
        year: year,
        categoryId: _categoryId,
      );

      state = state.copyWith(products: products, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}
