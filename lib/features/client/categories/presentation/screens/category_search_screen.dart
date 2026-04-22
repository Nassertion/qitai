import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/features/client/categories/presentation/provider/category_provider.dart';
import 'package:qitai/features/client/home/presentation/widgets/card_product_widget.dart';
import 'package:qitai/features/client/search/presentation/widgets/classification_widget.dart';

class CategorySearchScreen extends ConsumerWidget {
  const CategorySearchScreen({super.key, required this.id, required this.name});

  final int id;
  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);
    return Scaffold(
      appBar: CustomAppbar(
        title: name,
        action: IconButton(
          padding: const EdgeInsets.only(left: 4),
          onPressed: () {},
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
            SliverToBoxAdapter(
              child: Column(children: [const ClassificationWidget()]),
            ),

            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => const ProductCard(),
                childCount: 8,
              ),
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
