import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/core/constant/text_styles.dart';

class ProfileCard extends StatelessWidget {
  ProfileCard({super.key, required this.icon, required this.title});
  String icon;
  String title;
  //notificaon car and place
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 70,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                spacing: 8,
                children: [
                  SvgPicture.asset(icon),
                  Text(title, style: AppTextStyles.mediumCaption),
                ],
              ),
              SvgPicture.asset(
                "assets/icons/profile_icons/arrow-left.svg",
                width: 20,
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
