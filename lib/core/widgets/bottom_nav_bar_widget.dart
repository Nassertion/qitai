import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/core/constant/text_styles.dart';

const List<String> inactiveIcons = [
  "assets/icons/bottom_nav_bar_icons/inactive/home.svg",
  "assets/icons/bottom_nav_bar_icons/inactive/box.svg",
  "assets/icons/bottom_nav_bar_icons/inactive/shopping-cart.svg",
  "assets/icons/bottom_nav_bar_icons/inactive/profile.svg",
];

const List<String> activeIcons = [
  "assets/icons/bottom_nav_bar_icons/active/home.svg",
  "assets/icons/bottom_nav_bar_icons/active/box.svg",
  "assets/icons/bottom_nav_bar_icons/active/shopping-cart.svg",
  "assets/icons/bottom_nav_bar_icons/active/profile.svg",
];

const List<String> navTitle = ["الرئيسية", "طلباتي", "سلتي", "حسابي"];

class BottomFloatingNavBar extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onTap;

  const BottomFloatingNavBar({
    super.key,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          margin: const EdgeInsets.only(bottom: 10),
          height: 59,
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(navTitle.length, (index) {
              final bool isSelected = selected == index;

              return InkWell(
                onTap: () => onTap(index),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      isSelected ? activeIcons[index] : inactiveIcons[index],
                    ),
                    Text(
                      navTitle[index],
                      style: isSelected
                          ? AppTextStyles.boldOverline.copyWith(
                              color: AppColors.primaryButton,
                            )
                          : AppTextStyles.regularOverline.copyWith(
                              color: const Color(0xff949CA6),
                            ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
