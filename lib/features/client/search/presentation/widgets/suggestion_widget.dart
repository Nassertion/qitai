import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/core/constant/spaces.dart';
import 'package:qitai/core/constant/text_styles.dart';

class SuggestionWidget extends StatelessWidget {
  const SuggestionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      // padding: EdgeInsets.symmetric(vertical: 16),
      children: [
        InkWell(
          onTap: () => print("test"),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/images/search/test.png",
                    height: 44,
                    width: 44,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "فحمات",
                    style: AppTextStyles.mediumOverline.copyWith(
                      color: AppColors.primaryText,
                      height: 1,
                    ),
                  ),
                ],
              ),
              dPadding,
              Divider(color: AppColors.border, height: 1),
            ],
          ),
        ),
      ],
    );
  }
}
