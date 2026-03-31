import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/core/constant/spaces.dart';
import 'package:qitai/core/constant/text_styles.dart';
import 'package:qitai/core/widgets/floating_nav_bar_widget.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
  // String titles(data) {
  //   return Text(
  //     data,
  //     style: AppTextStyles.boldBody.copyWith(color: AppColors.actionText),
  //   ).toString();
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backgroudColor,
          bottom: TabBar(
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 1.5, color: AppColors.actionText),
              insets: EdgeInsetsGeometry.symmetric(horizontal: 48),
            ),
            indicatorPadding: EdgeInsetsGeometry.all(0),

            labelStyle: AppTextStyles.boldBody.copyWith(
              color: AppColors.actionText,
            ),
            unselectedLabelStyle: AppTextStyles.boldBody.copyWith(
              color: AppColors.disabledText,
            ),
            tabs: [
              Tab(text: "النشطة"),
              Tab(text: "السجل"),
            ],
          ),
          centerTitle: true,
          title: Text(
            "طلباتي",
            style: AppTextStyles.boldSubtitle.copyWith(
              color: AppColors.primaryText,
            ),
          ),
        ),
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                //in case no orders
                children: [
                  SvgPicture.asset("assets/icons/box.svg"),
                  dPadding,
                  Text(
                    "لاتوجد لديك طلبات حالية!",
                    style: AppTextStyles.boldSubtitle,
                  ),
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
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomFloatingNavBar(),
            ),
          ],
        ),
      ),
    );
  }
}
