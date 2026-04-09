import 'package:flutter/material.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/core/constant/text_styles.dart';

//شيك الرجوع بعدين
class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, required this.title, this.action});
  final String title;
  final Widget? action;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      title: Text(
        title,
        style: AppTextStyles.boldSubtitle.copyWith(
          color: AppColors.primaryText,
        ),
      ),
      centerTitle: true,
      actions: [?action],
    );
  }
}
