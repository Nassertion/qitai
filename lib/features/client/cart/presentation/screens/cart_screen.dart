import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/core/widgets/empty_data_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomeAppbar(
        title: "سلتي",
        action: IconButton(
          padding: EdgeInsets.only(left: 4),
          onPressed: () {},
          icon: SvgPicture.asset(
            "assets/icons/search-normal.svg",
            width: 24,
            height: 24,
            color: AppColors.primaryText,
          ),
        ),
      ),
      body: EmptyDataWidget(
        img: 'assets/icons/cart.svg',
        text: 'لاتوجد منتجات في السلة!',
        buttonText: "اضافة للسلة",
      ),
    );
  }
}
