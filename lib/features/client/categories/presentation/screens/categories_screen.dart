import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qitai/core/constant/text_styles.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/core/widgets/loading_widget.dart';
import 'package:qitai/features/client/categories/presentation/provider/category_provider.dart';
import 'package:qitai/features/client/categories/presentation/widgets/cateogry_card_widget.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: CustomeAppbar(title: "الفئات"),
      body: categoriesAsync.when(
        loading: () => const CustomeLoading(),
        error: (error, stack) => Center(
          child: Text(
            error.toString(),
            style: AppTextStyles.regularOverline.copyWith(color: Colors.red),
          ),
        ),
        data: (categories) {
          if (categories.isEmpty) {
            return const Center(child: Text("لا توجد فئات"));
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.95,
              ),
              itemBuilder: (context, index) {
                final category = categories[index];
                return CateogryCardWidget(category: category);
              },
            ),
          );
        },
      ),
    );
  }
}
