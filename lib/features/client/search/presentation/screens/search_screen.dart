import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qitai/core/constant/spaces.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/core/widgets/empty_data_widget.dart';
import 'package:qitai/core/widgets/loading_widget.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/core/widgets/search_widget.dart';
import 'package:qitai/features/client/search/presentation/widgets/classification_widget.dart';
import 'package:qitai/features/client/search/presentation/provider/search_provider.dart';
import 'package:qitai/features/client/search/presentation/widgets/search_card_product_widget.dart';
import 'package:qitai/features/client/search/presentation/widgets/search_suggestion_widget.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
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
            Padding12,
            SearchWidget(
              controller: _controller,
              onChanged: (value) {
                ref.read(searchProvider.notifier).onQueryChanged(value);
              },
              onFieldSubmitted: (value) {
                ref.read(searchProvider.notifier).submitSearch(value);
              },
              onClear: () {
                _controller.clear();
                ref.read(searchProvider.notifier).clearSearch();
              },
              onSearchTap: () {
                ref
                    .read(searchProvider.notifier)
                    .submitSearch(_controller.text);
              },
            ),
            const ClassificationWidget(),
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
                      itemCount: state.products.length,
                      separatorBuilder: (_, __) => Padding8,
                      itemBuilder: (context, index) {
                        final item = state.products[index];
                        return SearchCardProductWidget(product: item , onTap: () {
                          context.push("/product/${item.id}");
                        },);
                      },
                    );
                  }

                  if (state.hasSearched && state.products.isEmpty) {
                    return const EmptyDataWidget(
                      text: "لاتوجد نتائج في البحث!",
                      img: "assets/icons/Object.svg",
                    );
                  }

                  if (state.suggestions.isNotEmpty) {
                    return SingleChildScrollView(
                      child: SuggestionWidget(
                        suggestions: state.suggestions,
                        onTapSuggestion: (item) {
                          _controller.text = item.name;
                          ref
                              .read(searchProvider.notifier)
                              .submitSearch(item.name);
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
