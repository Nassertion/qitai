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

  int _requestVersion = 0;

  @override
  AllProductsState build() {
    getProducts = ref.read(getProductsProvider);

    ref.listen<VehicleState>(vehicleProvider(VehicleScope.browse), (
      previous,
      next,
    ) {
      if (!hasVehicleFiltersChanged(previous, next)) return;

      loadProducts();
    });

    Future.microtask(loadProducts);

    return const AllProductsState();
  }

  Future<void> loadProducts() async {
    final requestVersion = ++_requestVersion;

    final vehicleState = ref.read(vehicleProvider(VehicleScope.browse));

    final brandId = vehicleState.selectedCarBrand?.id;
    final modelId = vehicleState.selectedModel?.id;
    final year = vehicleState.selectedCarYear?.year;

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

      if (!ref.mounted || requestVersion != _requestVersion) {
        return;
      }

      state = state.copyWith(
        products: result.products,
        currentPage: result.currentPage,
        lastPage: result.lastPage,
        isLoading: false,
        isLoadingMore: false,
      );
    } catch (e) {
      if (!ref.mounted || requestVersion != _requestVersion) {
        return;
      }

      state = state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> loadNextPage() async {
    if (state.isLoading || state.isLoadingMore) return;
    if (!state.hasNextPage) return;

    final requestVersion = _requestVersion;

    final vehicleState = ref.read(vehicleProvider(VehicleScope.browse));

    final brandId = vehicleState.selectedCarBrand?.id;
    final modelId = vehicleState.selectedModel?.id;
    final year = vehicleState.selectedCarYear?.year;

    final nextPage = state.currentPage + 1;

    state = state.copyWith(isLoadingMore: true, clearErrorMessage: true);

    try {
      final result = await getProducts(
        brandId: brandId,
        modelId: modelId,
        year: year,
        page: nextPage,
      );

      if (!ref.mounted || requestVersion != _requestVersion) {
        return;
      }

      state = state.copyWith(
        products: [...state.products, ...result.products],
        currentPage: result.currentPage,
        lastPage: result.lastPage,
        isLoadingMore: false,
      );
    } catch (e) {
      if (!ref.mounted || requestVersion != _requestVersion) {
        return;
      }

      state = state.copyWith(isLoadingMore: false, errorMessage: e.toString());
    }
  }
}
