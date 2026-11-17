import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/text_styles.dart';

class CartSuccessNotice {
  const CartSuccessNotice._();

  static void show(
    BuildContext context, {
    required String message,
    int? subtotal,
  }) {
    final messenger = ScaffoldMessenger.of(context);

    messenger.hideCurrentSnackBar();

    messenger.showSnackBar(
      SnackBar(
        backgroundColor: AppColors.noInternet,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        padding: EdgeInsets.zero,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
        content: SizedBox(
          height: 52,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 20,
                  color: AppColors.successText,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          message,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.regularOverline.copyWith(
                            color: AppColors.whiteText,
                          ),
                        ),
                      ),
                      if (subtotal != null) ...[
                        const SizedBox(width: 4),
                        Text(
                          '$subtotal',
                          style: AppTextStyles.boldOverline.copyWith(
                            color: AppColors.whiteText,
                          ),
                        ),
                        const SizedBox(width: 2),
                        SvgPicture.asset(
                          'assets/icons/SR.svg',
                          width: 16,
                          height: 16,
                          colorFilter: const ColorFilter.mode(
                            AppColors.whiteText,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                InkWell(
                  onTap: messenger.hideCurrentSnackBar,
                  child: Text(
                    'إغلاق',
                    style: AppTextStyles.regularOverline.copyWith(
                      color: AppColors.whiteText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
