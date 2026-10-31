import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/core/widgets/empty_data_widget.dart';
import 'package:qitai/core/widgets/loading_widget.dart';

import 'package:qitai/features/client/categories/presentation/provider/category_product_notifier.dart';
import 'package:qitai/features/client/categories/presentation/widgets/category_filter_selector.dart';

import 'package:qitai/features/client/products/presentation/widgets/all_product_card_skeleton.dart';
import 'package:qitai/features/client/products/presentation/widgets/all_product_card_widget.dart';

import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_notifier.dart';

class CategoryProductsScreen extends StatelessWidget {
  const CategoryProductsScreen({
    super.key,
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        vehicleProvider.overrideWith(VehicleNotifier.new),
        categoryProductProvider(id).overrideWith(CategoryProductNotifier.new),
      ],
      child: _CategoryProductsContent(id: id, name: name),
    );
  }
}

class _CategoryProductsContent extends ConsumerStatefulWidget {
  const _CategoryProductsContent({required this.id, required this.name});

  final int id;
  final String name;

  @override
  ConsumerState<_CategoryProductsContent> createState() =>
      _CategoryProductsContentState();
}

class _CategoryProductsContentState
    extends ConsumerState<_CategoryProductsContent> {
  late final ScrollController _scrollController;

  // # Grid Layout
  static const _gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 16,
    mainAxisSpacing: 16,
    mainAxisExtent: 265,
  );

  // # Initialize
  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  // # Pagination
  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;

    if (position.pixels >= position.maxScrollExtent - 300) {
      ref.read(categoryProductProvider(widget.id).notifier).loadNextPage();
    }
  }

  // # Dispose
  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();

    super.dispose();
  }

  // # Products Skeleton
  Widget _buildProductsSkeleton() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          return const AllProductCardSkeleton();
        }, childCount: 6),
        gridDelegate: _gridDelegate,
      ),
    );
  }

  // # Build
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
          // # Category Filter
          CategoryFilterSelector(categoryId: widget.id),

          // # Products Content
          Expanded(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                // # Skeleton Loading
                if (productsState.isLoading)
                  _buildProductsSkeleton()
                // # Error State
                else if (productsState.errorMessage != null &&
                    productsState.products.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: Text(productsState.errorMessage!)),
                  )
                // # Empty State
                else if (productsState.products.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: EmptyDataWidget(
                      text: "لا توجد منتجات",
                      img: "assets/icons/Object.svg",
                    ),
                  )
                // # Products Grid
                else ...[
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final product = productsState.products[index];

                        return AllProductCardWidget(
                          product: product,
                          onTap: () {
                            context.push("/product/${product.id}");
                          },
                        );
                      }, childCount: productsState.products.length),
                      gridDelegate: _gridDelegate,
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 16)),

                  // # Pagination Loading
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
