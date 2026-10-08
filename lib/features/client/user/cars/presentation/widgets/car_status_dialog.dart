import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';

enum CarDialogType { success, error, warning }

class CarStatusDialog extends StatelessWidget {
  const CarStatusDialog({
    super.key,
    required this.type,
    required this.title,
    required this.message,
    this.buttonText = 'حسنًا',
  });

  final CarDialogType type;
  final String title;
  final String message;
  final String buttonText;

  static Future<void> show({
    required BuildContext context,
    required CarDialogType type,
    required String title,
    required String message,
    String buttonText = 'حسنًا',
  }) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.25),
      elevation: 0,
      isScrollControlled: true,
      builder: (_) {
        return CarStatusDialog(
          type: type,
          title: title,
          message: message,
          buttonText: buttonText,
        );
      },
    );
  }

  SvgPicture get _icon {
    switch (type) {
      case CarDialogType.success:
        return SvgPicture.asset(
          "assets/icons/car/tick-circle.svg",
          width: 60,
          height: 60,
        );

      case CarDialogType.error:
        return SvgPicture.asset(
          "assets/icons/car/close-circle.svg",
          width: 60,
          height: 60,
        );

      case CarDialogType.warning:
        return SvgPicture.asset(
          "assets/icons/car/warning.svg",
          width: 60,
          height: 60,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        decoration: const BoxDecoration(
          color: AppColors.inputFieldAndCards,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            _icon,

            h16,

            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.boldBody.copyWith(
                color: AppColors.primaryText,
              ),
            ),

            h8,

            // Message
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.regularOverline.copyWith(
                color: AppColors.secondaryText,
              ),
            ),

            h16,

            // Button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: Material(
                color: AppColors.primaryButton,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(16),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  overlayColor: const WidgetStatePropertyAll(
                    Colors.transparent,
                  ),
                  child: Center(
                    child: Text(
                      buttonText,
                      style: AppTextStyles.boldBody.copyWith(
                        color: AppColors.whiteText,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
