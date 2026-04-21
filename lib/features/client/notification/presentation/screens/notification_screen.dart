import 'package:flutter/material.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/features/client/notification/presentation/widgets/notification_card_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "الاشعارات"),
      body: AppPagePadding(
        child: ListView(
          children: [
            h12,
            NotificationCardWidget(
              time: "الآن",
              title: "يتوفر تحديث جديد للتطبيق",
              subtitle:
                  "قمنا بتحسين ميزة البحث وأيضًا بعض الميزات الأخرى، تأكد من تحديث التطبيق لآخر إصدار.",
              img: "assets/icons/update.svg",
              isNow: true,
            ),

            h16,
            NotificationCardWidget(
              time: "الآن",
              title: "تم توصيل طلبك بنجاح",
              subtitle:
                  "قمنا بتحسين ميزة البحث وأيضًا بعض الميزات الأخرى، تأكد من تحديث التطبيق لآخر إصدار.",
              img: "assets/icons/delivery.svg",
              isNow: true,
            ),

            h16,
            NotificationCardWidget(
              time: "قبل ساعة",
              title: "يتوفر تحديث جديد للتطبيق",
              subtitle:
                  "قمنا بتحسين ميزة البحث وأيضًا بعض الميزات الأخرى، تأكد من تحديث التطبيق لآخر إصدار.",
              img: "assets/icons/update.svg",
              isNow: false,
            ),

            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
