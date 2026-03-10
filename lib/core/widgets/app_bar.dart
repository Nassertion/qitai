import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qitai/core/constant/text_styles.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/features/client/temp_model/temp_client_model.dart';

ClientInfo clientInfo = ClientInfo(city: "الرياض", distrect: "العزيزية");
bool hasAddress = clientInfo.city.isNotEmpty && clientInfo.distrect.isNotEmpty;
//real data
AppBar appBar() {
  return AppBar(
    titleSpacing: 12,
    backgroundColor: AppColors.backgroudColor,

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
          hasAddress
              ? Text(
                  "${clientInfo.city}, ${clientInfo.distrect}",
                  style: AppTextStyles.mediumBody,
                )
              : Text("عنواني", style: AppTextStyles.mediumBody),
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
