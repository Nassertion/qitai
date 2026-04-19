import 'package:flutter/material.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/core/constant/spaces.dart';
import 'package:qitai/core/constant/text_styles.dart';
import 'package:qitai/core/widgets/button_widget.dart';
import 'package:qitai/core/widgets/page_padding.dart';

class AddToCartSection extends StatelessWidget {
  const AddToCartSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPagePadding(
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                    color: AppColors.inputFieldAndCards,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Column(
                    children: [
                      Text(
                        "الكمية",
                        style: AppTextStyles.semiBoldOverline.copyWith(
                          color: AppColors.secondaryText,
                        ),
                      ),
                      Padding4,
                      Text(
                        "1",
                        style: AppTextStyles.mediumOverline.copyWith(
                          color: AppColors.primaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Expanded(child: ButtonWidget(text: "أضف للسلة")),
              ],
            ),
          );
  }
}