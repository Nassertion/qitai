import 'package:flutter/material.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/core/widgets/page_padding.dart';

class AddCarScreen extends StatelessWidget {
  const AddCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "إضافة سيارة"),
      body: AppPagePadding(
        child: Column(
          children: [
            SizedBox(height: 24),
            Align(
              alignment: AlignmentGeometry.centerRight,
              child: Text("بيانات سيارتي ", style: AppTextStyles.boldBody),
            ),
          ],
        ),
      ),
    );
  }
}
