import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      appBar: CustomeAppbar(),
      body: AppPagePadding(
        child: ListView(
          padding: EdgeInsets.zero, // مهم
          children: [
            dPadding,
            search(),
            dPadding,
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
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero, // هنا تشيل padding الافتراضي
                    minimumSize: Size(0, 0), // optional لتقليل حجم الـ button
                    tapTargetSize: MaterialTapTargetSize
                        .shrinkWrap, // مهم لتصغير الـ hitbox
                  ),
                  child: Text(
                    "عرض الكل",
                    style: AppTextStyles.regularOverline.copyWith(
                      color: AppColors.actionText,
                    ),
                  ),
                ),
              ],
            ),
            dPadding12,
            Row(children: [addCar("assets/icons/addCar.svg", "اضف سيارتك")]),
            dPadding,
          ],
        ),
      ),
    );
  }

  //if no car -> default
  Column addCar(String img, String carName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 64,
          width: 64,
          child: CircleAvatar(
            backgroundColor: AppColors.backgroudColor,
            child: SvgPicture.asset(img),
          ),
        ),
        dPadding4,
        Text(
          carName,
          style: AppTextStyles.mediumOverline.copyWith(
            color: AppColors.primaryText,
          ),
        ),
      ],
    );
  }
}
