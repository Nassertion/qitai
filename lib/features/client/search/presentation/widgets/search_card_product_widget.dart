import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/core/constant/spaces.dart';
import 'package:qitai/core/constant/text_styles.dart';

class SearchCardProductWidget extends StatelessWidget {
  const SearchCardProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.inputFieldAndCards,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Image.asset(
                "assets/images/search/test2.png",
                width: 95,
                height: 95,
              ),
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
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
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "فحمات فرامل أمامية - كامري 2026",
                  style: AppTextStyles.semiBoldCaption.copyWith(
                    color: AppColors.primaryText,
                  ),
                ),
                Padding4,
                Text(
                  "رقم القطعة: 04465-06150",
                  style: AppTextStyles.mediumOverline.copyWith(
                    color: AppColors.secondaryText,
                  ),
                ),
                dPadding,
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
                        SizedBox(width: 2),
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
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
