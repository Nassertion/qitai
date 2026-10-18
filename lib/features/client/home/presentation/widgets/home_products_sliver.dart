import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:qitai/core/widgets/loading_widget.dart';
import 'package:qitai/features/client/products/presentation/provider/all_products_notifier.dart';
import 'package:qitai/features/client/products/presentation/widgets/all_product_card_widget.dart';

class HomeProductsSliver extends ConsumerWidget {
  const HomeProductsSliver({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsState = ref.watch(allProductsProvider);
    final products = productsState.products.take(4).toList();

    if (productsState.isLoading) {
      return const SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: CustomLoading(),
          ),
        ),
      );
    }

    if (productsState.errorMessage != null) {
      return SliverToBoxAdapter(
        child: Center(child: Text(productsState.errorMessage!)),
      );
    }

    if (products.isEmpty) {
      return const SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Text('لا توجد منتجات'),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 90),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          final product = products[index];

          return AllProductCardWidget(
            product: product,
            onTap: () {
              context.push('/product/${product.id}');
            },
          );
        }, childCount: products.length),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          mainAxisExtent: 260,
        ),
      ),
    );
  }
}
