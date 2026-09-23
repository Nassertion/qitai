import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qitai/core/helpers/auth_required.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/core/widgets/empty_data_widget.dart';
import 'package:qitai/core/widgets/page_padding.dart';

class ClientAddressesScreen extends ConsumerWidget {
  const ClientAddressesScreen({super.key});

  void _requireAuth(BuildContext context, WidgetRef ref) {
    requireAuth(
      context: context,
      ref: ref,
      onAuthenticated: () {
        // لاحقًا: فتح شاشة إضافة عنوان.
        // حاليًا لا نعمل شيئًا.
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'عناويني',
        action: IconButton(
          padding: const EdgeInsets.all(4),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          // overlayColor: const WidgetStatePropertyAll(
          //   Colors.transparent,
          // ),
          onPressed: () {
            _requireAuth(context, ref);
          },
          icon: SvgPicture.asset(
            'assets/icons/profile/add-circle.svg',
            width: 28,
            height: 28,
          ),
        ),
      ),
      body: AppPagePadding(
        child: EmptyDataWidget(
          img: 'assets/icons/profile/adress.svg',
          text: 'ليس لديك عناوين حاليًا!',
          buttonText: 'إضافة عنوان',
          onButtonPressed: () {
            _requireAuth(context, ref);
          },
        ),
      ),
    );
  }
}
