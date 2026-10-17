import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';

class ProductPrice extends StatelessWidget {
  const ProductPrice({super.key, required this.price});

  final Object price;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$price',
          style: AppTextStyles.semiBoldBody.copyWith(
            color: AppColors.primaryText,
          ),
        ),
        w2,
        SvgPicture.asset('assets/icons/SR.svg'),
      ],
    );
  }
}
