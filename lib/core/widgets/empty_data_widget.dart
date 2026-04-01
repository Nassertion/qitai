import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/core/constant/spaces.dart';
import 'package:qitai/core/constant/text_styles.dart';

class EmptyDataWidget extends StatelessWidget {
   EmptyDataWidget({super.key , required this.img , required this.text});
String img;
String text;
//ontab
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        //in case no orders
        children: [
          //"assets/icons/box.svg"
          SvgPicture.asset(img),
          dPadding,
          //"لاتوجد لديك طلبات حالية!"
          Text(text, style: AppTextStyles.boldSubtitle),
          SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              height: 54,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primaryButton,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                "اضافة طلب",
                style: AppTextStyles.boldBody.copyWith(
                  color: AppColors.whiteText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
