import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qitai/core/constant/colors.dart';

// make it work
TextFormField search() {
  return TextFormField(
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
      hintStyle: TextStyle(color: Colors.black45),
      filled: true,
      fillColor: AppColors.inputFieldAndCards,
    ),
  );
}
