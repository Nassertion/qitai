import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/core/widgets/empty_data_widget.dart';
import 'package:qitai/core/widgets/loading_widget.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/core/widgets/search_widget.dart';
import 'package:qitai/features/client/search/presentation/provider/search_notifier.dart';
import 'package:qitai/features/client/search/presentation/widgets/search_card_product_widget.dart';
import 'package:qitai/features/client/search/presentation/widgets/search_suggestion_widget.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_notifier.dart';
import 'package:qitai/features/client/vehicles/presentation/widgets/vehicles_widget.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final TextEditingController _controller;
  late final VehicleNotifier _vehicleNotifier;
  late final SearchNotifier _searchNotifier;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
    _vehicleNotifier = ref.read(vehicleProvider.notifier);
    _searchNotifier = ref.read(searchProvider.notifier);

    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    Future.microtask(() {
      _vehicleNotifier.clearAll();
      _searchNotifier.clearSearch();
    });
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;

    if (position.pixels >= position.maxScrollExtent - 300) {
      ref.read(searchProvider.notifier).loadNextPage();
    }
  }

  @override
  void dispose() {
    _controller.dispose();

    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchProvider);

    return Scaffold(
      appBar: CustomAppbar(
        title: "البحث",
        action: Container(
          padding: const EdgeInsets.all(16),
          child: SvgPicture.asset("assets/icons/shopping-cart.svg"),
        ),
      ),
      body: AppPagePadding(
        child: Column(
          children: [
            h12,
            SearchWidget(
              controller: _controller,
              onChanged: (value) {
                ref.read(searchProvider.notifier).onQueryChanged(value);
              },
              onFieldSubmitted: (value) {
                ref
                    .read(searchProvider.notifier)
                    .submitSearch(customQuery: value);
              },
              onClear: () {
                _controller.clear();
                ref.read(searchProvider.notifier).clearSearch();
              },
              onSearchTap: () {
                ref
                    .read(searchProvider.notifier)
                    .submitSearch(customQuery: _controller.text);
              },
            ),

            const VehiclesWidget(),

            Expanded(
              child: Builder(
                builder: (context) {
                  if (state.isProductsLoading) {
                    return const Center(child: CustomLoading());
                  }

                  if (state.isSuggestionsLoading) {
                    return const Center(child: CustomLoading());
                  }

                  if (state.products.isNotEmpty) {
                    return ListView.separated(
                      controller: _scrollController,
                      padding: const EdgeInsets.only(top: 8, bottom: 16),
                      itemCount:
                          state.products.length + (state.isLoadingMore ? 1 : 0),
                      separatorBuilder: (_, index) {
                        if (index >= state.products.length - 1) {
                          return const SizedBox.shrink();
                        }

                        return h8;
                      },
                      itemBuilder: (context, index) {
                        if (index >= state.products.length) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Center(child: CustomLoading()),
                          );
                        }

                        final item = state.products[index];

                        return SearchCardProductWidget(
                          product: item,
                          onTap: () {
                            context.push("/product/${item.id}");
                          },
                        );
                      },
                    );
                  }

                  if (state.hasSearched && state.products.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.only(bottom: 100),
                      child: EmptyDataWidget(
                        text: "لاتوجد نتائج في البحث!",
                        img: "assets/icons/Object.svg",
                      ),
                    );
                  }

                  if (state.suggestions.isNotEmpty) {
                    return SingleChildScrollView(
                      child: SearchSuggestionWidget(
                        suggestions: state.suggestions,
                        onTapSuggestion: (item) {
                          _controller.text = item.name;

                          ref
                              .read(searchProvider.notifier)
                              .submitSearch(customQuery: item.name);
                        },
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
