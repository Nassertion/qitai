import 'package:flutter/material.dart';

import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmText,
    this.cancelText = 'تراجع',
    this.confirmColor = AppColors.errorText,
  });

  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final Color confirmColor;

  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
    required String confirmText,
    String cancelText = 'تراجع',
    Color confirmColor = AppColors.errorText,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (_) {
        return ConfirmationDialog(
          title: title,
          message: message,
          confirmText: confirmText,
          cancelText: cancelText,
          confirmColor: confirmColor,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          h12,
          Text(
            title,
            style: AppTextStyles.boldBody,
            textAlign: TextAlign.center,
          ),

          h4,

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.regularOverline,
            ),
          ),

          h12,

          Divider(height: 1, color: AppColors.border),

          SizedBox(
            height: 45,
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: const ButtonStyle(
                      overlayColor: WidgetStatePropertyAll(Colors.transparent),
                      splashFactory: NoSplash.splashFactory,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      cancelText,
                      style: AppTextStyles.regularBody.copyWith(
                        color: AppColors.onPrimary,
                      ),
                    ),
                  ),
                ),

                Container(
                  width: 1,
                  height: double.infinity,
                  color: AppColors.border,
                ),

                Expanded(
                  child: TextButton(
                    style: const ButtonStyle(
                      overlayColor: WidgetStatePropertyAll(Colors.transparent),
                      splashFactory: NoSplash.splashFactory,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text(
                      confirmText,
                      style: AppTextStyles.boldBody.copyWith(
                        color: confirmColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
