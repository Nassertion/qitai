import 'package:qitai/features/client/products/domain/usecases/get_products.dart';
import 'package:qitai/features/client/products/presentation/provider/all_products_state.dart';
import 'package:qitai/features/client/products/presentation/provider/product_provider.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_notifier.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_state.dart';
import 'package:qitai/features/client/vehicles/presentation/utils/vehicle_filter_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'all_products_notifier.g.dart';

@Riverpod(keepAlive: true)
class AllProductsNotifier extends _$AllProductsNotifier {
  late final GetProducts getProducts;

  @override
  AllProductsState build() {
    getProducts = ref.read(getProductsProvider);

   ref.listen<VehicleState>(vehicleProvider, (previous, next) {
  if (!hasVehicleFiltersChanged(previous, next)) return;

  loadProducts();
});

    Future.microtask(loadProducts);

    return const AllProductsState();
  }

  Future<void> loadProducts() async {
    final classificationState = ref.read(vehicleProvider);

    final brandId = classificationState.selectedCarBrand?.id;
    final modelId = classificationState.selectedModel?.id;
    final year = classificationState.selectedCarYear?.year;

    state = state.copyWith(
      isLoading: true,
      isLoadingMore: false,
      currentPage: 1,
      lastPage: 1,
      clearErrorMessage: true,
    );

    try {
      final result = await getProducts(
        brandId: brandId,
        modelId: modelId,
        year: year,
        page: 1,
      );

      state = state.copyWith(
        products: result.products,
        currentPage: result.currentPage,
        lastPage: result.lastPage,
        isLoading: false,
        isLoadingMore: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> loadNextPage() async {
    if (state.isLoading) return;
    if (state.isLoadingMore) return;
    if (!state.hasNextPage) return;

    final classificationState = ref.read(vehicleProvider);

    final brandId = classificationState.selectedCarBrand?.id;
    final modelId = classificationState.selectedModel?.id;
    final year = classificationState.selectedCarYear?.year;

    final nextPage = state.currentPage + 1;

    state = state.copyWith(
      isLoadingMore: true,
      clearErrorMessage: true,
    );

    try {
      final result = await getProducts(
        brandId: brandId,
        modelId: modelId,
        year: year,
        page: nextPage,
      );

      state = state.copyWith(
        products: [
          ...state.products,
          ...result.products,
        ],
        currentPage: result.currentPage,
        lastPage: result.lastPage,
        isLoadingMore: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        errorMessage: e.toString(),
      );
    }
  }
}