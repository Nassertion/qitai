import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qitai/core/constants/text_styles.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, this.icon, required this.title, this.img});
  final String? icon;
  final String title;
  final String? img;
  //notificaon car and place
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 70,
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: img != null ? 12 : 24,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                spacing: 8,
                children: [
                  if (icon != null) SvgPicture.asset(icon!),
                  if (img != null)
                    SvgPicture.asset(img!, height: 48, width: 48),
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
