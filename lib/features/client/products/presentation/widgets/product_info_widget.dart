import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/core/constant/spaces.dart';
import 'package:qitai/core/constant/text_styles.dart';
import 'package:qitai/core/widgets/page_padding.dart';

class ProductInfoWidget extends StatelessWidget {
  const ProductInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPagePadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "بواجي - كامري 2026",
            style: AppTextStyles.boldBody.copyWith(color: AppColors.primaryText),
          ),
          Padding4,
          Text(
            "رقم القطعة: 254-550",
            style: AppTextStyles.mediumOverline.copyWith(
              color: AppColors.secondaryText,
            ),
          ),
          Padding12,
          Text(
            "بواجي ليزر من شركة NGK",
            style: AppTextStyles.regularCaption.copyWith(
              color: AppColors.primaryText,
            ),
          ),
          Padding12,
          Row(
            children: [
              Text(
                "250",
                style: AppTextStyles.semiBoldBody.copyWith(
                  color: AppColors.primaryText,
                ),
              ),
              SizedBox(width: 2),
              SvgPicture.asset("assets/icons/SR.svg"),
            ],
          ),
          Divider(color: AppColors.border),
          Padding8,
          Row(
            children: [
              Text(
                "الجودة: ",
                style: AppTextStyles.regularCaption.copyWith(
                  color: AppColors.secondaryText,
                ),
              ),
              Text(
                "أصلي",
                style: AppTextStyles.semiBoldOverline.copyWith(
                  color: AppColors.primaryText,
                ),
              ),
            ],
          ),
          Padding4,
          Row(
            children: [
              Text(
                "التوافقية: ",
                style: AppTextStyles.regularCaption.copyWith(
                  color: AppColors.secondaryText,
                ),
              ),
              Text(
                "هذا المنتج متوافق مع الموديلات من 2024-2026",
                style: AppTextStyles.semiBoldOverline.copyWith(
                  color: AppColors.primaryText,
                ),
              ),
            ],
          ),
          Padding8,
          Divider(color: AppColors.border),
        ],
      ),
    );
  }
}
