import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/core/constant/spaces.dart';
import 'package:qitai/core/constant/text_styles.dart';
import 'package:qitai/core/widgets/button_widget.dart';

class EmptyDataWidget extends StatelessWidget {
  EmptyDataWidget({
    super.key,
    required this.img,
    required this.text,
    required this.buttonText,
  });
  String img;
  String text;
  String buttonText;
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
          SizedBox(height: 100, width: 130, child: SvgPicture.asset(img)),
          dPadding,
          //"لاتوجد لديك طلبات حالية!"
          Text(text, style: AppTextStyles.boldSubtitle),
          SizedBox(height: 48),
          ButtonWidget(text: buttonText),
        ],
      ),
    );
  }
}
