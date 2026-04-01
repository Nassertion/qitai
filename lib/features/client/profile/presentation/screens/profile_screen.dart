import 'package:flutter/material.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/core/constant/spaces.dart';
import 'package:qitai/core/constant/text_styles.dart';
import 'package:qitai/core/widgets/Page_padding.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/core/widgets/button_widget.dart';
import 'package:qitai/features/client/profile/presentation/widget/profile_card_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomeAppbar(title: "حسابي"),
      body: Builder(
        builder: (context) {
          return AppPagePadding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding8,
                Text(
                  "قم بتسجيل الدخول\nاو انشاء حساب جديد",
                  style: AppTextStyles.semiBoldCaption.copyWith(
                    color: AppColors.primaryText,
                  ),
                ),
                dPadding,
                ButtonWidget(text: "تسجيل الدخول", height: 45.0),
                SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.inputFieldAndCards,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      ProfileCard(
                        icon: 'assets/icons/profile_icons/car.svg',
                        title: 'سياراتي',
                      ),
                      Divider(color: AppColors.border),

                      ProfileCard(
                        icon: 'assets/icons/profile_icons/location.svg',
                        title: 'عناويني',
                      ),
                      Divider(color: AppColors.border),

                      ProfileCard(
                        icon: 'assets/icons/profile_icons/language.svg',
                        title: 'اللغة',
                      ),
                      Divider(color: AppColors.border),

                      ProfileCard(
                        icon: 'assets/icons/profile_icons/info.svg',
                        title: 'من نحن ',
                      ),
                      Divider(color: AppColors.border),

                      ProfileCard(
                        icon: 'assets/icons/profile_icons/Headset.svg',
                        title: 'مركز المساعدة',
                      ),
                      Divider(color: AppColors.border),

                      ProfileCard(
                        icon: 'assets/icons/profile_icons/clipboard-text.svg',
                        title: 'الشروط والاحكام',
                      ),
                      Divider(color: AppColors.border),

                      ProfileCard(
                        icon: 'assets/icons/profile_icons/security-safe.svg',
                        title: 'سياسات التطبيق',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
