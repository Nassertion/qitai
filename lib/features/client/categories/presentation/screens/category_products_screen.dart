import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/core/widgets/empty_data_widget.dart';
import 'package:qitai/core/widgets/loading_widget.dart';
import 'package:qitai/features/client/categories/presentation/provider/category_product_notifier.dart';
import 'package:qitai/features/client/categories/presentation/widgets/category_product_card_widget.dart';
import 'package:qitai/features/client/categories/presentation/widgets/category_filter_selector.dart';

class CategoryProductsScreen extends ConsumerStatefulWidget {
  const CategoryProductsScreen({
    super.key,
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  ConsumerState<CategoryProductsScreen> createState() =>
      _CategoryProductsScreenState();
}

class _CategoryProductsScreenState
    extends ConsumerState<CategoryProductsScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;

    if (position.pixels >= position.maxScrollExtent - 300) {
      ref.read(categoryProductProvider(widget.id).notifier).loadNextPage();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(categoryProductProvider(widget.id));

    return Scaffold(
      appBar: CustomAppbar(
        title: widget.name,
        action: IconButton(
          padding: const EdgeInsets.only(left: 4),
          onPressed: () {
            context.push("/search");
          },
          icon: SvgPicture.asset(
            "assets/icons/search-normal.svg",
            width: 24,
            height: 24,
          ),
        ),
      ),
      body: Column(
        children: [
          CategoryFilterSelector(categoryId: widget.id),
          Expanded(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                if (productsState.isLoading)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: CustomLoading()),
                  )
                else if (productsState.errorMessage != null &&
                    productsState.products.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: Text(productsState.errorMessage!)),
                  )
                else if (productsState.products.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: EmptyDataWidget(
                      text: "لا توجد منتجات",
                      img: "assets/icons/Object.svg",
                    ),
                  )
                else ...[
                  SliverPadding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final product = productsState.products[index];

                        return CategoryProductCardWidget(
                          product: product,
                          onTap: () {
                            context.push("/product/${product.id}");
                          },
                        );
                      }, childCount: productsState.products.length),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            mainAxisExtent: 265,
                          ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 16)),

                  if (productsState.isLoadingMore)
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(child: CustomLoading()),
                      ),
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
