import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/core/constant/text_styles.dart';
import 'package:qitai/features/client/categories/data/model/cateogry_model.dart';
import 'package:qitai/features/client/categories/data/repository/category_repository.dart';

class CateogryCardWidget extends StatelessWidget {
  const CateogryCardWidget({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final imagePath = getIcon(category.name);

    return
    //  InkWell(onTap: () => context.push("/categories/"),
    //   child:
    Container(
      decoration: BoxDecoration(
        color: AppColors.backgroudColor,
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
                return const Icon(Icons.image_not_supported_outlined, size: 40);
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
    );
    // );
  }
}
