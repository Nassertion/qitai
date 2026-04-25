import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qitai/features/client/search/data/repository/search_repository.dart';
import 'package:qitai/features/client/search/presentation/provider/search_provider.dart';
import 'package:qitai/features/client/search/presentation/provider/search_state.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicles.provider.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicles_state.dart';

class SearchNotifier extends Notifier<SearchState> {
  late final SearchRepository repo;
  Timer? _debounce;

  @override
  SearchState build() {
    repo = ref.read(searchRepositoryProvider);

    ref.onDispose(() {
      _debounce?.cancel();
    });

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

      if (!state.hasSearched) return;

      submitSearch();
    });

    return const SearchState();
  }

  void onQueryChanged(String value) {
    final query = value.trim();

    state = state.copyWith(
      query: value,
      products: [],
      hasSearched: false,
      clearErrorMessage: true,
    );

    _debounce?.cancel();

    if (query.isEmpty) {
      state = state.copyWith(
        suggestions: [],
        products: [],
        hasSearched: false,
        isSuggestionsLoading: false,
        isProductsLoading: false,
      );
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 300), () {
      loadSuggestions(query);
    });
  }

  Future<void> loadSuggestions(String query) async {
    state = state.copyWith(isSuggestionsLoading: true, clearErrorMessage: true);

    try {
      final suggestions = await repo.fetchSuggestions(query: query);

      if (state.query.trim() != query) return;

      state = state.copyWith(
        suggestions: suggestions,
        isSuggestionsLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isSuggestionsLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> submitSearch({
  String? customQuery,
  int? categoryId,
}) async {
    final rawValue = customQuery ?? state.query;
    final value = rawValue.trim();

    final classificationState = ref.read(classificationProvider);

    final brandId = classificationState.selectedCarBrand?.id;
    final modelId = classificationState.selectedModel?.id;
    final year = classificationState.selectedCarYear?.year;
    final finalCategoryId = categoryId ?? state.categoryId;

    _debounce?.cancel();

    final hasText = value.isNotEmpty;
    final hasVehicleFilter = brandId != null || modelId != null || year != null;

   final hasCategoryFilter = finalCategoryId != null;

if (!hasText && !hasVehicleFilter && !hasCategoryFilter) return;

    state = state.copyWith(
      query: value,
      suggestions: [],
      products: [],
      hasSearched: true,
      isProductsLoading: true,
      clearErrorMessage: true,
      categoryId: finalCategoryId,
    );

    try {
      final isVin = hasText && _isVin(value);

      final products = await repo.searchProducts(
        query: hasText && !isVin ? value : null,
        vin: hasText && isVin ? value : null,
        brandId: brandId,
        modelId: modelId,
        year: year,
        categoryId: finalCategoryId,
      );

      state = state.copyWith(products: products, isProductsLoading: false);
    } catch (e) {
      state = state.copyWith(
        isProductsLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  void clearSearch() {
    _debounce?.cancel();
    state = const SearchState();
  }

  bool _isVin(String value) {
    final vinRegex = RegExp(r'^[A-HJ-NPR-Z0-9]{17}$', caseSensitive: false);
    return vinRegex.hasMatch(value);
  }
}
