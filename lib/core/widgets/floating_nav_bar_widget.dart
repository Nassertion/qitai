import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/core/constant/text_styles.dart';

class CustomFloatingNavBar extends StatefulWidget {
  const CustomFloatingNavBar({super.key});

  @override
  State<CustomFloatingNavBar> createState() => _CustomFloatingNavBarState();
}

class _CustomFloatingNavBarState extends State<CustomFloatingNavBar> {
  int selected = 0;

  final List<String> inactive = [
    "assets/icons/bottom_nav_bar_icons/inactive/home.svg",
    "assets/icons/bottom_nav_bar_icons/inactive/box.svg",
    "assets/icons/bottom_nav_bar_icons/inactive/shopping-cart.svg",
    "assets/icons/bottom_nav_bar_icons/inactive/profile.svg",
  ];

  final List<String> active = [
    "assets/icons/bottom_nav_bar_icons/active/home.svg",
    "assets/icons/bottom_nav_bar_icons/active/box.svg",
    "assets/icons/bottom_nav_bar_icons/active/shopping-cart.svg",
    "assets/icons/bottom_nav_bar_icons/active/profile.svg",
  ];

  final List<String> title = ["الرئيسية", "طلباتي", "سلتي", "حسابي"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        margin: const EdgeInsets.only(bottom: 10),
        height: 59,
        decoration: BoxDecoration(
          color: AppColors.backgroudColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        //temp state
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          spacing: 20,
          children: List.generate(title.length, (index) {
            final bool isSelected = selected == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selected = index;
                });
              },
              child: Material(
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      isSelected ? active[index] : inactive[index],
                    ),
                    Text(
                      title[index],
                      style: isSelected
                          ? AppTextStyles.boldOverline.copyWith(
                              color: AppColors.primaryButton,
                            )
                          : AppTextStyles.regularOverline.copyWith(
                              color: Color(0xff949CA6),
                            ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
