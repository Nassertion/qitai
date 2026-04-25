import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/core/widgets/loading_widget.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/features/client/categories/presentation/provider/category_provider.dart';
import 'package:qitai/features/client/categories/presentation/widgets/category_product_card_widget.dart';
import 'package:qitai/features/client/home/presentation/widgets/card_product_widget.dart';
import 'package:qitai/features/client/search/presentation/provider/search_provider.dart';
import 'package:qitai/features/client/search/presentation/widgets/classification_widget.dart';

class CategorySearchScreen extends ConsumerStatefulWidget {
  const CategorySearchScreen({super.key, required this.id, required this.name});

  final int id;
  final String name;

  @override
  ConsumerState<CategorySearchScreen> createState() =>
      _CategorySearchScreenState();
}

class _CategorySearchScreenState extends ConsumerState<CategorySearchScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(searchProvider.notifier).submitSearch(categoryId: widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchProvider);

    return Scaffold(
      appBar: CustomAppbar(
        title: widget.name,
        action: IconButton(
          padding: const EdgeInsets.only(left: 4),
          onPressed: () async {
            ref.read(searchProvider.notifier).clearSearch();

            await context.push("/search");
            ref
                .read(searchProvider.notifier)
                .submitSearch(categoryId: widget.id);
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
            const SliverToBoxAdapter(child: ClassificationWidget()),

            if (searchState.isProductsLoading)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: CustomLoading()),
              )
            else
              SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final product = searchState.products[index];

                  return CategoryProductCardWidget(
                    product: product,
                    onTap: () {
                      context.push("/product/${product.id}");
                    },
                  );
                }, childCount: searchState.products.length),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  mainAxisExtent: 265,
                ),
              ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}
