import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

TextFormField search() {
  return TextFormField(
    style: TextStyle(color: Colors.black87),
    decoration: InputDecoration(
      prefixIcon:
          //  Icon(Icons.abc),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset(
              "assets/icons/search-normal.svg",
              width: 20,
              height: 20,
              fit: BoxFit.contain,
            ),
          ),
      hintText: "ابحث برقم الشاصي أو القطعة ورقمها",
      hintStyle: TextStyle(color: Colors.black45),
      filled: true,
      fillColor: Colors.white,
    ),
  );
}
