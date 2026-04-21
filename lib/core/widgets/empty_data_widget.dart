import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/core/widgets/button_widget.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({
    super.key,
    required this.img,
    required this.text,
    this.buttonText,
  });
  final String img;
  final String text;
  final String? buttonText;
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
          h16,
          Text(text, style: AppTextStyles.boldSubtitle),
          if (buttonText != null) ...[
            SizedBox(height: 48),
            ButtonWidget(text: buttonText!),
          ],
        ],
      ),
    );
  }
}
