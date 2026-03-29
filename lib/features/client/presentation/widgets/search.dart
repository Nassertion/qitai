import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/core/constant/text_styles.dart';

// make it work
SizedBox search() {
  return SizedBox(
    height: 44,
    child: TextFormField(
      textAlignVertical: TextAlignVertical.center,
      style: TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SvgPicture.asset(
            "assets/icons/search-normal.svg",
            width: 20,
            height: 20,
            fit: BoxFit.contain,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(231, 233, 234, 1)),
          borderRadius: BorderRadius.circular(12),
        ),

        hintText: "ابحث برقم الشاصي أو القطعة ورقمها",
        hintStyle: AppTextStyles.regularOverline.copyWith(
          color: AppColors.secondaryText,
        ),
        contentPadding: EdgeInsets.zero,
        filled: true,
        fillColor: AppColors.inputFieldAndCards,
      ),
    ),
  );
}
