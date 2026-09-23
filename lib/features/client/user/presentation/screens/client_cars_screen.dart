import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qitai/core/helpers/auth_required.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/core/widgets/empty_data_widget.dart';
import 'package:qitai/core/widgets/page_padding.dart';

class ClientCarsScreen extends ConsumerWidget {
  const ClientCarsScreen({super.key});

  void _requireAuth(BuildContext context, WidgetRef ref) {
    requireAuth(
      context: context,
      ref: ref,
      onAuthenticated: () {
        // لاحقًا: فتح شاشة إضافة سيارة.
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'سياراتي',
        action: IconButton(
          padding: const EdgeInsets.all(4),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
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
          img: 'assets/icons/profile/noCar.svg',
          text: 'ليس لديك سيارات حاليًا!',
          buttonText: 'إضافة سيارة',
          onButtonPressed: () {
            _requireAuth(context, ref);
          },
        ),
      ),
    );
  }
}
