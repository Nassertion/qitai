import 'dart:async';

import 'package:qitai/features/client/products/domain/usecases/get_products.dart';
import 'package:qitai/features/client/products/presentation/provider/product_provider.dart';
import 'package:qitai/features/client/search/domain/usecases/get_search_suggestions.dart';
import 'package:qitai/features/client/search/presentation/provider/search_state.dart';
import 'package:qitai/features/client/search/presentation/provider/search_suggestions_provider.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicles_notifier.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicles_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_notifier.g.dart';

@riverpod
class SearchNotifier extends _$SearchNotifier {
  late final GetSearchSuggestions getSuggestions;
  late final GetProducts getProducts;

  Timer? _debounce;
  int _searchRequestId = 0;

  @override
  SearchState build() {
    getProducts = ref.read(getProductsProvider);
    getSuggestions = ref.read(getSearchSuggestionsProvider);

    ref.onDispose(() {
      _debounce?.cancel();
    });

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
      currentPage: 1,
      lastPage: 1,
      isLoadingMore: false,
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
        isLoadingMore: false,
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
      final suggestions = await getSuggestions(query: query);

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

  Future<void> submitSearch({String? customQuery, int? categoryId}) async {
    final rawValue = customQuery ?? state.query;
    final value = rawValue.trim().toUpperCase();

    final classificationState = ref.read(vehicleProvider);

    final brandId = classificationState.selectedCarBrand?.id;
    final modelId = classificationState.selectedModel?.id;
    final year = classificationState.selectedCarYear?.year;
    // final finalCategoryId = categoryId ?? state.categoryId;

    _debounce?.cancel();

    final hasText = value.isNotEmpty;
    final hasVehicleFilter = brandId != null || modelId != null || year != null;
    // final hasCategoryFilter = finalCategoryId != null;

    if (!hasText && !hasVehicleFilter) {
      return;
    }

    final requestId = ++_searchRequestId;

    state = state.copyWith(
      query: value,
      suggestions: [],
      products: [],
      hasSearched: true,
      isProductsLoading: true,
      isLoadingMore: false,
      currentPage: 1,
      lastPage: 1,
      clearErrorMessage: true,
      // categoryId: finalCategoryId,
    );

    try {
      final isVin = hasText && _isVin(value);

      final result = await getProducts(
        query: hasText && !isVin ? value : null,
        vin: hasText && isVin ? value : null,
        brandId: brandId,
        modelId: modelId,
        year: year,
        // categoryId: finalCategoryId,
        page: 1,
      );

      if (!ref.mounted) return;
      if (requestId != _searchRequestId) return;

      state = state.copyWith(
        products: result.products,
        currentPage: result.currentPage,
        lastPage: result.lastPage,
        isProductsLoading: false,
        isLoadingMore: false,
      );
    } catch (e) {
      if (!ref.mounted) return;
      if (requestId != _searchRequestId) return;

      state = state.copyWith(
        isProductsLoading: false,
        isLoadingMore: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> loadNextPage() async {
    if (state.isProductsLoading) return;
    if (state.isLoadingMore) return;
    if (!state.hasNextPage) return;

    final value = state.query.trim().toUpperCase();

    final classificationState = ref.read(vehicleProvider);

    final brandId = classificationState.selectedCarBrand?.id;
    final modelId = classificationState.selectedModel?.id;
    final year = classificationState.selectedCarYear?.year;
    // final finalCategoryId = state.categoryId;

    final nextPage = state.currentPage + 1;

    state = state.copyWith(isLoadingMore: true, clearErrorMessage: true);

    try {
      final isVin = value.isNotEmpty && _isVin(value);

      final result = await getProducts(
        query: value.isNotEmpty && !isVin ? value : null,
        vin: value.isNotEmpty && isVin ? value : null,
        brandId: brandId,
        modelId: modelId,
        year: year,
        // categoryId: finalCategoryId,
        page: nextPage,
      );

      if (!ref.mounted) return;

      state = state.copyWith(
        products: [...state.products, ...result.products],
        currentPage: result.currentPage,
        lastPage: result.lastPage,
        isLoadingMore: false,
      );
    } catch (e) {
      if (!ref.mounted) return;

      state = state.copyWith(isLoadingMore: false, errorMessage: e.toString());
    }
  }

  void clearSearch() {
    _debounce?.cancel();
    _searchRequestId++;
    state = const SearchState();
  }

  bool _isVin(String value) {
    final vinRegex = RegExp(r'^[A-Z0-9]{17}$', caseSensitive: false);

    return vinRegex.hasMatch(value);
  }
}
