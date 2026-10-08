import 'package:flutter/material.dart';

import 'package:qitai/core/widgets/confirmation_dialog.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const ConfirmationDialog(
      title: 'تسجيل الخروج',
      message:
          'سيتم تسجيل الخروج من حسابك لكن ستبقى بياناتك موجودة في حال عودتك، هل تريد المتابعة؟',
      confirmText: 'تسجيل الخروج',
    );
  }

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (_) => const ConfirmationDialog(
        title: 'تسجيل الخروج',
        message:
            'سيتم تسجيل الخروج من حسابك لكن ستبقى بياناتك موجودة في حال عودتك، هل تريد المتابعة؟',
        confirmText: 'تسجيل الخروج',
      ),
    );
  }
}