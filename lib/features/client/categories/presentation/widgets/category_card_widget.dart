import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/features/client/categories/domain/entities/category.dart';

class CategoryCardWidget extends StatelessWidget {
  const CategoryCardWidget({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    final imagePath = getIcon(category.name);

    return InkWell(
      onTap: () =>
          context.push("/categories/${category.id}", extra: category.name),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Stack(
          children: [
            Center(
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
            Positioned(
              right: 8,
              bottom: 5,
              child: Text(
                category.name,
                style: AppTextStyles.semiBoldCaption.copyWith(
                  color: AppColors.primaryText,
                ),
              ),
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