import 'package:flutter/material.dart';
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
      //real data
      // backgroundColor: Color.fromRGBO(239, 240, 242, 1),
      // backgroundColor: Color(0xFFFFFEFD),
      appBar: appBar(),
      body: AppPagePadding(
        child: Column(
          children: [
            Dpadding,
            search(),
            Dpadding,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "سيارتي",
                  style: AppTextStyles.boldBody,
                  textHeightBehavior: const TextHeightBehavior(
                    applyHeightToFirstAscent: false,
                    applyHeightToLastDescent: false,
                  ),
                ),
                Text("عرض الكل", style: AppTextStyles.regularOverline),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
