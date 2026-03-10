import 'package:flutter/material.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/core/constant/text_styles.dart';
import 'package:qitai/core/constant/spaces.dart';
import 'package:qitai/core/widgets/Page_padding.dart';
import 'package:qitai/core/widgets/app_bar.dart';
import 'package:qitai/core/widgets/search.dart';

class ClientScreen extends StatelessWidget {
  const ClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: AppPagePadding(
        child: ListView(
          children: [
            Dpadding,
            search(),
            Dpadding,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "سيارتي",
                  style: AppTextStyles.boldBody.copyWith(
                    color: AppColors.primaryText,
                  ),
                ),
                // make it work
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "عرض الكل",
                    style: AppTextStyles.regularOverline.copyWith(
                      color: AppColors.actionText,
                    ),
                  ),
                ),
              ],
            ),
            Dpadding12,
            //count data
            // ListView.builder(itemBuilder: (context, index) {}),
          ],
        ),
      ),
    );
  }
}
