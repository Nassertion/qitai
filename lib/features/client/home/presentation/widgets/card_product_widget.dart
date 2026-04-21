import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});
  // اصلي وتجاري
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 163,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.image,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  'assets/images/test.png',
                  fit: BoxFit.contain,
                ),
              ),

              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.actionText,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    "أصلي",
                    style: AppTextStyles.semiBoldOverline.copyWith(
                      color: AppColors.whiteText,
                    ),
                  ),
                ),
              ),
            ],
          ),

          h8,
          Text(
            "اسطب خلفي كامري 2026",
            style: AppTextStyles.semiBoldOverline.copyWith(
              color: AppColors.primaryText,
            ),
          ),
          h4,
          Text(
            "رقم القطعة: 254-550",
            style: AppTextStyles.regularOverline.copyWith(
              color: AppColors.secondaryText,
            ),
          ),

          h8,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "300",
                    style: AppTextStyles.semiBoldBody.copyWith(
                      color: AppColors.primaryText,
                    ),
                  ),
                  w2,
                  SvgPicture.asset("assets/icons/SR.svg"),
                ],
              ),

              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.primaryButton,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
