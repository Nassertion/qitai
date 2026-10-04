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
    this.enabled = true,
  });

  final String text;
  final double? height;
  final double? width;
  final VoidCallback? onPressed;

  /// عند false يظهر الزر بحالة التعطيل (disabledButton) ولا يستجيب للضغط.
  /// القيمة الافتراضية true حتى لا يتأثر أي استخدام حالي للزر.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      onTap: enabled ? onPressed : null,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 54,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: enabled ? AppColors.primaryButton : AppColors.disabledButton,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: AppTextStyles.boldBody.copyWith(
            color: enabled ? AppColors.whiteText : AppColors.disabledText,
          ),
        ),
      ),
    );
  }
}