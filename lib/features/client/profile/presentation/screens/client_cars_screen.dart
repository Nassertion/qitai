import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/core/widgets/button_widget.dart';
import 'package:qitai/core/widgets/empty_data_widget.dart';
import 'package:qitai/core/widgets/page_padding.dart';

class ClientCarsScreen extends StatelessWidget {
  const ClientCarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "سياراتي",
        action: IconButton(
          padding: EdgeInsets.only(left: 4),
          onPressed: () {},
          icon: SvgPicture.asset(
            "assets/icons/profile/add-circle.svg",
            width: 28,
            height: 28,
          ),
        ),
        // action: SvgPicture.asset("assets/icons/profile/add-circle.svg"),
      ),
      body: AppPagePadding(
        child: EmptyDataWidget(
          img: "assets/icons/profile/noCar.svg",
          text: "ليس لديك سيارات حاليًا!",
          buttonText: "إضافة سيارة",
        ),
      ),
    );
  }
}
