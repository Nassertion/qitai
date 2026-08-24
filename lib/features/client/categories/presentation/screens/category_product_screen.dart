import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/core/widgets/loading_widget.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/features/client/categories/presentation/provider/category_product_notifier.dart';
import 'package:qitai/features/client/categories/presentation/widgets/category_product_card_widget.dart';
import 'package:qitai/features/client/search/presentation/widgets/classification_widget.dart';

class CategoryProductsScreen extends ConsumerWidget {
  const CategoryProductsScreen({
    super.key,
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsState = ref.watch(categoryProductProvider(id));

    return Scaffold(
      appBar: CustomAppbar(
        title: name,
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
      body: AppPagePadding(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: ClassificationWidget(),
            ),

            if (productsState.isLoading)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: CustomLoading(),
                ),
              )
            else if (productsState.errorMessage != null)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text(productsState.errorMessage!),
                ),
              )
            else
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = productsState.products[index];

                    return CategoryProductCardWidget(
                      product: product,
                      onTap: () {
                        context.push("/product/${product.id}");
                      },
                    );
                  },
                  childCount: productsState.products.length,
                ),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  mainAxisExtent: 265,
                ),
              ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),
          ],
        ),
      ),
    );
  }
}