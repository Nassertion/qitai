import 'package:flutter/material.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/core/constant/text_styles.dart';

//شيك الرجوع بعدين
class CustomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  CustomeAppbar({super.key, required this.title, this.action});
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  String title;
  Widget? action;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroudColor,
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
