import 'package:flutter/material.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/text_styles.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool showAction;

  const SectionHeader({
    super.key,
    required this.title,
    this.onTap,
    this.showAction = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.boldBody.copyWith(
              color: AppColors.primaryText,
            ),
          ),
          if (showAction)
            TextButton(
              onPressed: onTap,
              style:
                  TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.centerLeft,
                  ).copyWith(
                    overlayColor: WidgetStatePropertyAll(Colors.transparent),
                    splashFactory: NoSplash.splashFactory,
                  ),
              child: Text(
                "عرض الكل",
                style: AppTextStyles.regularOverline.copyWith(
                  color: AppColors.actionText,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
