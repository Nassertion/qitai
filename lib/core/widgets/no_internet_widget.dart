import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/core/network/internet_connection_provider.dart';
import 'package:qitai/core/widgets/page_padding.dart';

class NoInternetWidget extends ConsumerWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final internetStatus = ref.watch(internetStatusProvider);

    return internetStatus.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (status) {
        if (status == InternetStatus.connected) {
          return const SizedBox.shrink();
        }

        return AppPagePadding(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 25),
            decoration: BoxDecoration(
              color: AppColors.noInternet,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),

            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () async {
                      final hasInternet =
                          await InternetConnection().hasInternetAccess;

                      if (hasInternet) {
                        ref.invalidate(internetStatusProvider);
                      }
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/offline.svg',
                          height: 20,
                          width: 20,
                        ),
                        // const Icon(
                        //   Icons.wifi_off_rounded,
                        //   color: AppColors.errorText,
                        //   size: 20,
                        // ),
                        w8,
                        Text(
                          'لا يوجد اتصال بالإنترنت.',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.regularOverline.copyWith(
                            color: AppColors.whiteText,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Row(
                    children: [
                      Text(
                        'أعد الاتصال',
                        style: AppTextStyles.boldOverline.copyWith(
                          color: AppColors.whiteText,
                        ),
                      ),
                      w4,
                      SvgPicture.asset(
                        "assets/icons/refresh.svg",
                        height: 20,
                        width: 20,
                      ),
                      // const Icon(
                      //   Icons.refresh,
                      //   color: AppColors.whiteText,
                      //   size: 20,
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
