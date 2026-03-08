import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qitai/core/constant/app_text_styles.dart';

//real data
AppBar appBar() {
  return AppBar(
    backgroundColor: Color.fromRGBO(239, 240, 242, 1),
    titleSpacing: 12,

    title: SizedBox(
      height: 56,
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/icons/location-add.svg",
            width: 24,
            height: 24,
          ),
          SizedBox(width: 4),
          Text("عنواني", style: AppTextStyles.mediumBody),
        ],
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: SvgPicture.asset(
          "assets/icons/notification-bing.svg",
          width: 24,
          height: 24,
        ),
      ),
    ],
  );
}
