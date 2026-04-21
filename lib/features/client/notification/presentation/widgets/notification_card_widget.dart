import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';

class NotificationCardWidget extends StatelessWidget {
  final String time; //temp future datatime
  final String title;
  final String subtitle;
  final String img;
  final bool isNow;

  const NotificationCardWidget({
    super.key,
    required this.time,
    required this.title,
    required this.subtitle,
    required this.img,
    this.isNow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.inputFieldAndCards,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // icon
                  SvgPicture.asset(img, height: 40, width: 40),

                  w12,

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: AppTextStyles.semiBoldBody),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: AppTextStyles.regularOverline.copyWith(
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // الوقت فوق (ما يأثر على عرض النص)
              Positioned(
                top: 5,
                left: 0,
                child: Row(
                  children: [
                    Text(
                      time,
                      style: AppTextStyles.regularOverline.copyWith(
                        color: AppColors.secondaryText,
                      ),
                    ),
                    w8,
                    if (isNow)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xff1565C0),
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),

          // const SizedBox(height: 6),

          // // subtitle full width
          // Text(
          //   subtitle,
          //   textAlign: TextAlign.right,
          //   style: AppTextStyles.regularOverline.copyWith(
          //     color: AppColors.secondaryText,
          //   ),
          //   maxLines: 2,
          //   overflow: TextOverflow.ellipsis,
          // ),
        ],
      ),
    );
  }
}
