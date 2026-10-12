import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/features/client/categories/domain/entities/category.dart';
import 'package:qitai/features/client/categories/presentation/provider/category_product_count_provider.dart';

class CategoryCardWidget extends ConsumerWidget {
  const CategoryCardWidget({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagePath = getIcon(category.name);
    final countAsync = ref.watch(categoryProductsCountProvider(category.id));

    final countText = countAsync.when(
      data: (count) => '$count منتج',
      loading: () => '...',
      error: (_, _) => '',
    );

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () =>
          context.push("/categories/${category.id}", extra: category.name),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.inputFieldAndCards,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.image,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.image_not_supported_outlined,
                      size: 40,
                    );
                  },
                ),
              ),
            ),

            h12,

            Text(
              category.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.semiBoldCaption.copyWith(
                color: AppColors.primaryText,
              ),
            ),

            h4,

            Row(
              children: [
                Text(
                  countText,
                  style: AppTextStyles.regularOverline.copyWith(
                    color: AppColors.secondaryText,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: AppColors.secondaryText,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String getIcon(String name) {
  switch (name) {
    case "الفرامل":
      return "assets/images/cate/breaks.png";
    case "المحرك":
      return "assets/images/cate/test30.png";
    case "الكهرباء":
      return "assets/images/cate/boaji.png";
    case "الزيوت والسوائل":
      return "assets/images/cate/oils.png";
    case "التعليق":
      return "assets/images/cate/t3le8.png";
    default:
      return "assets/images/cate/default.png";
  }
}
