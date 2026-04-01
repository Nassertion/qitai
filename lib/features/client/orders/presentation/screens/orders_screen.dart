import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/core/constant/spaces.dart';
import 'package:qitai/core/constant/text_styles.dart';
import 'package:qitai/core/widgets/Page_padding.dart';
import 'package:qitai/core/widgets/floating_nav_bar_widget.dart';
import 'package:qitai/core/widgets/empty_data_widget.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});
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
        body: TabBarView(
          children: [
            AppPagePadding(
              child: EmptyDataWidget(
                img: "assets/icons/box.svg",
                text: "لاتوجد لديك طلبات حالية!",
                buttonText: "اضافة طلب",
              ),
            ),
            AppPagePadding(
              child: EmptyDataWidget(
                img: "assets/icons/record.svg",
                text: "السجل فارغ حاليا قم بانشاء طلب",
                buttonText: "اضافة طلب",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
