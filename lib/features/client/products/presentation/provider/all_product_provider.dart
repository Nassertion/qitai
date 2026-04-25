import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qitai/features/client/products/presentation/provider/all_product_state.dart';
import 'package:qitai/features/client/search/data/repository/search_repository.dart';
import 'package:qitai/features/client/search/presentation/provider/search_provider.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicles.provider.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicles_state.dart';

final allProductsProvider =
    NotifierProvider<AllProductsNotifier, AllProductsState>(
  AllProductsNotifier.new,
);

class AllProductsNotifier extends Notifier<AllProductsState> {
  late final SearchRepository repo;

  @override
  AllProductsState build() {
    repo = ref.read(searchRepositoryProvider);

    ref.listen<ClassificationState>(classificationProvider, (previous, next) {
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

    return const AllProductsState();
  }

  Future<void> loadProducts() async {
    final classificationState = ref.read(classificationProvider);

    final brandId = classificationState.selectedCarBrand?.id;
    final modelId = classificationState.selectedModel?.id;
    final year = classificationState.selectedCarYear?.year;

    state = state.copyWith(
      isLoading: true,
      clearErrorMessage: true,
    );

    try {
      final products = await repo.searchProducts(
        brandId: brandId,
        modelId: modelId,
        year: year,
      );

      state = state.copyWith(
        products: products,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }
}