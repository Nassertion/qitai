import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/core/constant/spaces.dart';
import 'package:qitai/core/constant/text_styles.dart';

//if no car -> default
//temp
class AddCar extends StatelessWidget {
  final String img;
  final String carName;
  const AddCar({super.key, required this.img, required this.carName});
  @override
  Widget build(BuildContext context) {
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
        Padding4,
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
