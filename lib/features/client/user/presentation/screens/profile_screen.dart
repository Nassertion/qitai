import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/core/helpers/auth_required.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/core/widgets/button_widget.dart';
import 'package:qitai/features/client/auth/presentation/providers/auth_notifier.dart';
import 'package:qitai/features/client/user/presentation/providers/current_user_notifier.dart';
import 'package:qitai/features/client/user/presentation/widgets/logout_dialog.dart';
import 'package:qitai/features/client/user/presentation/widgets/profile_card_widget.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    return Scaffold(
      appBar: CustomAppbar(title: "حسابي"),
      body: AppPagePadding(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              h8,
              if (currentUser == null) ...[
                Text(
                  'قم بتسجيل الدخول\nاو انشاء حساب جديد',
                  style: AppTextStyles.semiBoldCaption.copyWith(
                    color: AppColors.primaryText,
                  ),
                ),
                h16,
                ButtonWidget(
                  text: 'تسجيل الدخول',
                  height: 45,
                  onPressed: () => requireAuth(
                    context: context,
                    ref: ref,
                    onAuthenticated: () {},
                  ),
                ),
                SizedBox(height: 24),
              ] else ...[
                InkWell(
                  onTap: () => context.push("/profile/edit"),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.inputFieldAndCards,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: ProfileCard(
                      img:
                          'assets/icons/user.svg', //should be avatar user as defualt when logged in and must support svg png etc.. NOT ONLY SVG
                      title:
                          'Username', // should be user name as default when logged in username
                    ),
                  ),
                ),
                h16,

                // Text(
                //   'مرحبًا ${currentUser.name}',
                //   style: AppTextStyles.semiBoldCaption.copyWith(
                //     color: AppColors.primaryText,
                //   ),
                // ),
                // h16,
                // ButtonWidget(
                //   text: 'حسابي',
                //   height: 45,
                //   onPressed: () {
                //     context.push('/profile');
                //   },
                // ),
              ],
              // SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.inputFieldAndCards,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => context.push("/profile/car"),
                      child: ProfileCard(
                        icon: 'assets/icons/profile_icons/car.svg',
                        title: 'سياراتي',
                      ),
                    ),
                    Divider(color: AppColors.border),

                    InkWell(
                      onTap: () => context.push("/profile/adress"),
                      child: ProfileCard(
                        icon: 'assets/icons/profile_icons/location.svg',
                        title: 'عناويني',
                      ),
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

              if (currentUser != null) ...[
                h16,
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  overlayColor: const WidgetStatePropertyAll(
                    Colors.transparent,
                  ),
                  onTap: () async {
                    final shouldLogout = await LogoutDialog.show(context);

                    if (shouldLogout != true || !context.mounted) {
                      return;
                    }

                    await ref.read(authProvider.notifier).logout();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/profile_icons/logout.svg',
                        ),
                        w8,
                        Text(
                          'تسجيل الخروج',
                          style: AppTextStyles.mediumOverline.copyWith(
                            color: AppColors.errorText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
