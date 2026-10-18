import 'dart:async';

import 'package:qitai/features/client/products/domain/usecases/get_products.dart';
import 'package:qitai/features/client/products/presentation/provider/product_provider.dart';
import 'package:qitai/features/client/search/domain/usecases/get_search_suggestions.dart';
import 'package:qitai/features/client/search/presentation/provider/search_state.dart';
import 'package:qitai/features/client/search/presentation/provider/search_suggestions_provider.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_notifier.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_state.dart';
import 'package:qitai/features/client/vehicles/presentation/utils/vehicle_filter_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_notifier.g.dart';

@riverpod
class SearchNotifier extends _$SearchNotifier {
  late final GetSearchSuggestions getSuggestions;
  late final GetProducts getProducts;

  Timer? _debounce;

  int _searchRequestId = 0;
  int _suggestionsRequestId = 0;

  @override
  SearchState build() {
    getProducts = ref.read(getProductsProvider);
    getSuggestions = ref.read(getSearchSuggestionsProvider);

    ref.onDispose(() {
      _debounce?.cancel();
      _searchRequestId++;
      _suggestionsRequestId++;
    });

    ref.listen<VehicleState>(vehicleProvider(VehicleScope.browse), (
      previous,
      next,
    ) {
      if (!hasVehicleFiltersChanged(previous, next)) return;

      unawaited(submitSearch());
    });

    return const SearchState();
  }

  void onQueryChanged(String value) {
    final query = value.trim();

    _debounce?.cancel();

    // Invalidate previous product and suggestion requests.
    _searchRequestId++;
    _suggestionsRequestId++;

    state = state.copyWith(
      query: value,
      suggestions: [],
      products: [],
      hasSearched: false,
      isSuggestionsLoading: false,
      isProductsLoading: false,
      isLoadingMore: false,
      currentPage: 1,
      lastPage: 1,
      clearErrorMessage: true,
    );

    if (query.isEmpty) return;

    _debounce = Timer(const Duration(milliseconds: 300), () {
      unawaited(loadSuggestions(query));
    });
  }

  Future<void> loadSuggestions(String query) async {
    final requestId = ++_suggestionsRequestId;

    state = state.copyWith(isSuggestionsLoading: true, clearErrorMessage: true);

    try {
      final suggestions = await getSuggestions(query: query);

      if (!ref.mounted ||
          requestId != _suggestionsRequestId ||
          state.query.trim() != query) {
        return;
      }

      state = state.copyWith(
        suggestions: suggestions,
        isSuggestionsLoading: false,
      );
    } catch (e) {
      if (!ref.mounted ||
          requestId != _suggestionsRequestId ||
          state.query.trim() != query) {
        return;
      }

      state = state.copyWith(
        isSuggestionsLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> submitSearch({String? customQuery}) async {
    final rawValue = customQuery ?? state.query;
    final value = rawValue.trim().toUpperCase();

    final vehicleState = ref.read(vehicleProvider(VehicleScope.browse));

    final brandId = vehicleState.selectedCarBrand?.id;
    final modelId = vehicleState.selectedModel?.id;
    final year = vehicleState.selectedCarYear?.year;

    _debounce?.cancel();
    _suggestionsRequestId++;

    final requestId = ++_searchRequestId;

    final hasText = value.isNotEmpty;
    final hasVehicleFilter = brandId != null || modelId != null || year != null;

    if (!hasText && !hasVehicleFilter) {
      state = state.copyWith(
        query: value,
        suggestions: [],
        products: [],
        hasSearched: false,
        isSuggestionsLoading: false,
        isProductsLoading: false,
        isLoadingMore: false,
        currentPage: 1,
        lastPage: 1,
        clearErrorMessage: true,
      );

      return;
    }

    state = state.copyWith(
      query: value,
      suggestions: [],
      products: [],
      hasSearched: true,
      isSuggestionsLoading: false,
      isProductsLoading: true,
      isLoadingMore: false,
      currentPage: 1,
      lastPage: 1,
      clearErrorMessage: true,
    );

    try {
      final params = _buildSearchParams(value);

      final result = await getProducts(
        query: params.query,
        vin: params.vin,
        brandId: brandId,
        modelId: modelId,
        year: year,
        page: 1,
      );

      if (!ref.mounted || requestId != _searchRequestId) {
        return;
      }

      state = state.copyWith(
        products: result.products,
        currentPage: result.currentPage,
        lastPage: result.lastPage,
        isProductsLoading: false,
        isLoadingMore: false,
      );
    } catch (e) {
      if (!ref.mounted || requestId != _searchRequestId) {
        return;
      }

      state = state.copyWith(
        isProductsLoading: false,
        isLoadingMore: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> loadNextPage() async {
    if (state.isProductsLoading || state.isLoadingMore) return;
    if (!state.hasSearched || !state.hasNextPage) return;

    final requestId = _searchRequestId;
    final value = state.query.trim().toUpperCase();

    final vehicleState = ref.read(vehicleProvider(VehicleScope.browse));

    final brandId = vehicleState.selectedCarBrand?.id;
    final modelId = vehicleState.selectedModel?.id;
    final year = vehicleState.selectedCarYear?.year;

    final nextPage = state.currentPage + 1;

    state = state.copyWith(isLoadingMore: true, clearErrorMessage: true);

    try {
      final params = _buildSearchParams(value);

      final result = await getProducts(
        query: params.query,
        vin: params.vin,
        brandId: brandId,
        modelId: modelId,
        year: year,
        page: nextPage,
      );

      if (!ref.mounted || requestId != _searchRequestId) {
        return;
      }

      state = state.copyWith(
        products: [...state.products, ...result.products],
        currentPage: result.currentPage,
        lastPage: result.lastPage,
        isLoadingMore: false,
      );
    } catch (e) {
      if (!ref.mounted || requestId != _searchRequestId) {
        return;
      }

      state = state.copyWith(isLoadingMore: false, errorMessage: e.toString());
    }
  }

  void clearSearch() {
    _debounce?.cancel();

    _searchRequestId++;
    _suggestionsRequestId++;

    state = const SearchState();
  }

  ({String? query, String? vin}) _buildSearchParams(String value) {
    final hasText = value.isNotEmpty;
    final isVin = hasText && _isVin(value);

    return (
      query: hasText && !isVin ? value : null,
      vin: hasText && isVin ? value : null,
    );
  }

  bool _isVin(String value) {
    final vinRegex = RegExp(r'^[A-Z0-9]{17}$', caseSensitive: false);

    return vinRegex.hasMatch(value);
  }
}
