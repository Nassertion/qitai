import 'package:flutter/material.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),

          Text(
            'تسجيل الخروج',
            style: AppTextStyles.boldBody,
            textAlign: TextAlign.center,
          ),

          h4,

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'سيتم تسجيل الخروج من حسابك لكن ستبقى بياناتك موجودة في حال عودتك، هل تريد المتابعة؟',
              textAlign: TextAlign.center,
              style: AppTextStyles.regularOverline,
            ),
          ),

          h16,

          Divider(height: 1, color: AppColors.border),

          SizedBox(
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
  style: ButtonStyle(
    overlayColor: const WidgetStatePropertyAll(
      Colors.transparent,
    ),
    splashFactory: NoSplash.splashFactory,
  ),
  onPressed: () {
    Navigator.of(context).pop(false);
  },
  child: Text(
    'تراجع',
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
                  child:TextButton(
  style: ButtonStyle(
    overlayColor: const WidgetStatePropertyAll(
      Colors.transparent,
    ),
    splashFactory: NoSplash.splashFactory,
  ),
  onPressed: () {
    Navigator.of(context).pop(true);
  },
  child: Text(
    'تسجيل الخروج',
    style: AppTextStyles.boldBody.copyWith(
      color: AppColors.errorText,
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

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (_) => const LogoutDialog(),
    );
  }
}
