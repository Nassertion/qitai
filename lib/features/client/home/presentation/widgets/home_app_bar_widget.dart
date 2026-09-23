import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/helpers/auth_required.dart';

class HomeAppBarWidget extends ConsumerWidget implements PreferredSizeWidget {
  const HomeAppBarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      titleSpacing: 0,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      title: Row(
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            onTap: () {
              requireAuth(
                context: context,
                ref: ref,
                onAuthenticated: () {
                  context.push('/profile/adress');
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SvgPicture.asset(
                'assets/icons/location-add.svg',
                width: 24,
                height: 24,
              ),
            ),
          ),

          w4,

          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            onTap: () {
              requireAuth(
                context: context,
                ref: ref,
                onAuthenticated: () {
                  context.push('/profile/adress');
                },
              );
            },
            child: Text(
              'عنواني',
              style: AppTextStyles.mediumBody,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              width: 40,
              height: 40,
              child: Stack(
                children: [
                  InkWell(
                    onTap: () => context.push('/notifications'),
                    child: SvgPicture.asset(
                      'assets/icons/notification-bing.svg',
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
