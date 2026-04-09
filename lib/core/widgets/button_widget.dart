import 'package:flutter/material.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/core/constant/text_styles.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.text , this.height});
  final String text;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height ?? 54,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.primaryButton,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: AppTextStyles.boldBody.copyWith(color: AppColors.whiteText),
      ),
    );
  }
}
