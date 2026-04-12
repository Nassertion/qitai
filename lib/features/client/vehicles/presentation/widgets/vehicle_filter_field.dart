import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/core/constant/text_styles.dart';

class VehicleFilterField extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool isSelectedStyle;
  final VoidCallback? onDelete;

  const VehicleFilterField({
    super.key,
    required this.title,
    this.onTap,
    this.isSelectedStyle = false,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelectedStyle ? AppColors.actionText : AppColors.border,
          ),
          borderRadius: BorderRadius.circular(12),
          color: AppColors.inputFieldAndCards,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: isSelectedStyle
                    ? AppTextStyles.mediumCaption.copyWith(
                        color: AppColors.actionText,
                        height: 1,
                      )
                    : AppTextStyles.regularOverline.copyWith(
                        color: AppColors.secondaryText,
                      ),
              ),
              isSelectedStyle
                  ? GestureDetector(
                      onTap: onDelete,
                      child: SvgPicture.asset(
                        "assets/icons/close-circle.svg",
                      ),
                    )
                  : SvgPicture.asset(
                      "assets/icons/arrow-down.svg",
                      height: 16,
                      width: 16,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}