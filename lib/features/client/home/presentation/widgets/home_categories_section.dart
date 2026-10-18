import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/core/widgets/loading_widget.dart';
import 'package:qitai/features/client/categories/presentation/provider/category_provider.dart';

class HomeCategoriesSection extends ConsumerWidget {
  const HomeCategoriesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return SizedBox(
      height: 95,
      child: categoriesAsync.when(
        loading: () => const CustomLoading(),
        error: (error, stack) => Center(
          child: Text(
            error.toString(),
            style: AppTextStyles.regularOverline.copyWith(color: Colors.red),
          ),
        ),
        data: (categories) => ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          separatorBuilder: (_, _) => w12,
          itemBuilder: (context, index) {
            final category = categories[index];

            return InkWell(
              onTap: () => context.push(
                '/categories/${category.id}',
                extra: category.name,
              ),
              child: Column(
                children: [
                  Image.asset(
                    getCategoryIcon(category.name),
                    width: 74,
                    height: 56,
                  ),
                  h8,
                  Text(
                    category.name,
                    style: AppTextStyles.mediumOverline.copyWith(
                      color: AppColors.primaryText,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// مؤقتًا لحين ربط صور الفئات بالبيانات
String getCategoryIcon(String name) {
  switch (name) {
    case 'الفرامل':
      return 'assets/images/breaks.png';
    case 'المحرك':
      return 'assets/images/engine.png';
    case 'الكهرباء':
      return 'assets/images/boaji.png';
    case 'الزيوت والسوائل':
      return 'assets/images/oils.png';
    case 'التعليق':
      return 'assets/images/t3le8.png';
    default:
      return 'assets/images/default.png';
  }
}
