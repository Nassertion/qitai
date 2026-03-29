import 'package:flutter/material.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/core/constant/text_styles.dart';

Row sectionHeader(String name) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        name,
        style: AppTextStyles.boldBody.copyWith(color: AppColors.primaryText),
      ),
      // make it work
      TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size(0, 0),
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
