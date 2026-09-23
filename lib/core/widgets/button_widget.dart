import 'package:flutter/material.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/text_styles.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.text,
    this.height,
    this.width,
    this.onPressed,
  });

  final String text;
  final double? height;
  final double? width;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      onTap: onPressed,
      child: Container(
        width: width ?? double.infinity,
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
      ),
    );
  }
}
