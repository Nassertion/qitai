import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qitai/core/constant/colors.dart';
import 'package:qitai/core/constant/spaces.dart';
import 'package:qitai/core/constant/text_styles.dart';

class VehicleFilterBottomSheet {
  static Future<void> show<T>({
    required BuildContext context,
    required List<T> items,
    required String title,
    required String Function(T item) getLabel,
    required ValueChanged<T> onSelected,
  }) async {
    final result = await showModalBottomSheet<T>(
      context: context,
      backgroundColor: AppColors.inputFieldAndCards,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: 35,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xffB5BBC2),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              dPadding,
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  title,
                  style: AppTextStyles.boldBody.copyWith(
                    color: AppColors.primaryText,
                  ),
                ),
              ),
              dPadding,
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];

                    return InkWell(
                      onTap: () {
                        Navigator.pop(context, item);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Transform.translate(
                                  offset: Offset(0, 1),
                                  child: SvgPicture.asset(
                                    "assets/icons/Logo.svg.svg",
                                    height: 20,
                                    width: 24,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  getLabel(item),
                                  style: AppTextStyles.mediumCaption.copyWith(
                                    color: AppColors.primaryText,
                                    height: 1,
                                  ),
                                ),
                              ],
                            ),
                            dPadding,
                            Divider(color: AppColors.border, height: 1),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );

    if (result != null) {
      onSelected(result);
    }
  }
}
