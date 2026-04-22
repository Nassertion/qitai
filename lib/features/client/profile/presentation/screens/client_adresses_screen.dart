import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/core/widgets/button_widget.dart';
import 'package:qitai/core/widgets/empty_data_widget.dart';
import 'package:qitai/core/widgets/page_padding.dart';

class ClientAdressesScreen extends StatelessWidget {
  const ClientAdressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "عناويني",
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
          img: "assets/icons/profile/adress.svg",
          text: "ليس لديك عناوين حاليًا!",
          buttonText: "إضافة عنوان",
        ),
      ),
    );
  }
}
