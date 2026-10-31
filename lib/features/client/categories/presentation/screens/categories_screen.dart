import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/features/client/categories/presentation/provider/category_provider.dart';
import 'package:qitai/features/client/categories/presentation/widgets/categories_grid_skeleton.dart';
import 'package:qitai/features/client/categories/presentation/widgets/category_card_widget.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  // # Grid Layout
  static const _gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 16,
    mainAxisSpacing: 16,
    childAspectRatio: 0.73,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppbar(title: "الفئات"),
      body: categoriesAsync.when(
        // # Loading
        skipLoadingOnRefresh: false,
        loading: () => CategoriesGridSkeleton(
          itemCount: categoriesAsync.asData?.value.length ?? 6,
        ),

        // # Error
        error: (error, stack) => Center(
          child: Text(
            error.toString(),
            style: AppTextStyles.regularOverline.copyWith(color: Colors.red),
          ),
        ),

        // # Categories
        data: (categories) {
          if (categories.isEmpty) {
            return const Center(child: Text("لا توجد فئات"));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: categories.length,
            gridDelegate: _gridDelegate,
            itemBuilder: (context, index) {
              return CategoryCardWidget(category: categories[index]);
            },
          );
        },
      ),
    );
  }
}
