import 'package:flutter/material.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/core/constant/text_styles.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.boldBody.copyWith(color: AppColors.primaryText),
        ),
        if (showAction)
          TextButton(
            onPressed: onTap,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              "عرض الكل",
              style: AppTextStyles.regularOverline.copyWith(
                color: AppColors.actionText,
              ),
            ),
          ),
      ],
    );
  }
}
