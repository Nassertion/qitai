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

  // late final int _parentCategoryId;

  @override
  CategoryProductState build(int categoryId) {
    getProducts = ref.read(getProductsProvider);

    // _parentCategoryId = categoryId;

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

    Future.microtask(loadProducts);

    return CategoryProductState(
      parentCategoryId: categoryId,
      selectedCategoryId: categoryId,
    );
  }

  Future<void> loadProducts() async {
    final vehicleState = ref.read(vehicleProvider);

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
        categoryId: state.selectedCategoryId,
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

    final vehicleState = ref.read(vehicleProvider);

    final brandId = vehicleState.selectedCarBrand?.id;
    final modelId = vehicleState.selectedModel?.id;
    final year = vehicleState.selectedCarYear?.year;

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
        categoryId: state.selectedCategoryId,
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

  Future<void> selectSection(int categoryId) async {
    if (categoryId == state.selectedCategoryId) return;

    state = state.copyWith(
      selectedCategoryId: categoryId,
    );

    await loadProducts();
  }

  Future<void> clearSection() async {
    if (state.selectedCategoryId == state.parentCategoryId) return;

    state = state.copyWith(
      selectedCategoryId: state.parentCategoryId,
    );

    await loadProducts();
  }
}