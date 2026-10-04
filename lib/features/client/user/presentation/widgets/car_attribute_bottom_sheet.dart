import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';

class CarAttributeOption {
  final String title;
  final String iconAsset;

  const CarAttributeOption({
    required this.title,
    required this.iconAsset,
  });
}

class CarAttributeBottomSheet extends StatelessWidget {
  final String title;
  final List<CarAttributeOption> options;

  const CarAttributeBottomSheet({
    super.key,
    required this.title,
    required this.options,
  });

  static Future<String?> show({
    required BuildContext context,
    required String title,
    required List<CarAttributeOption> options,
  }) {
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.25),
      isScrollControlled: true,
      elevation: 0,
      builder: (_) {
        return CarAttributeBottomSheet(
          title: title,
          options: options,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.inputFieldAndCards,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            h16,

            // Handle
            Container(
              width: 35,
              height: 5,
              decoration: BoxDecoration(
                color: const Color(0xFFA8B0B8),
                borderRadius: BorderRadius.circular(16),
              ),
            ),

            h16,

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  title,
                  textAlign: TextAlign.right,
                  style: AppTextStyles.boldBody.copyWith(
                    color: AppColors.primaryText,
                  ),
                ),
              ),
            ),

            h8,

            // Options
            ...List.generate(options.length, (index) {
              final option = options[index];

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context, option.title);
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    overlayColor: const WidgetStatePropertyAll(
                      Colors.transparent,
                    ),
                    child: SizedBox(
                      height: 44,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SvgPicture.asset(
                                option.iconAsset,
                                width: 24,
                                height: 24,
                              ),

                              const SizedBox(width: 8),

                              Text(
                                option.title,
                                textAlign: TextAlign.right,
                                style: AppTextStyles.mediumCaption.copyWith(
                                  color: AppColors.primaryText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  if (index != options.length - 1)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: Color(0xFFE5E5E5),
                      ),
                    ),
                ],
              );
            }),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}