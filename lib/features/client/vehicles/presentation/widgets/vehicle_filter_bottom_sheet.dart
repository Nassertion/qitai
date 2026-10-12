import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/features/client/user/cars/domain/entities/user_car.dart';

class VehicleFilterBottomSheet {
  static Future<void> show<T>({
    required BuildContext context,
    required List<T> items,
    required String title,
    required String Function(T item) getLabel,
    required ValueChanged<T> onSelected,
    VoidCallback? onRetry,
    List<UserCar> savedCars = const [],
    ValueChanged<UserCar>? onUserCarSelected,
    int? selectedCarId,
  }) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.inputFieldAndCards,
      isScrollControlled: true,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final showSavedCars = savedCars.isNotEmpty && onUserCarSelected != null;

        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.67,

          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
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

                  h16,

                  if (showSavedCars) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'اختر من سياراتك',
                          style: AppTextStyles.boldBody.copyWith(
                            color: AppColors.primaryText,
                          ),
                        ),
                      ),
                    ),

                    h12,

                    SizedBox(
                      width: double.infinity,
                      height: 88,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          scrollDirection: Axis.horizontal,
                          itemCount: savedCars.length,
                          separatorBuilder: (_, _) => const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            final car = savedCars[index];

                            return _SavedCarItem(
                              car: car,
                              isSelected: car.id == selectedCarId,
                              onTap: () {
                                Navigator.pop(context);
                                onUserCarSelected(car);
                              },
                            );
                          },
                        ),
                      ),
                    ),

                    h12,
                  ],

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        title,
                        style: AppTextStyles.boldBody.copyWith(
                          color: AppColors.primaryText,
                        ),
                      ),
                    ),
                  ),

                  h4,

                  Expanded(
                    child: items.isEmpty
                        ? Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                onRetry?.call();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryButton,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'إعادة المحاولة',
                                  style: AppTextStyles.mediumCaption.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                final item = items[index];

                                return InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    onSelected(item);
                                  },
                                  child: Column(
                                    children: [
                                      h16,
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/Logo.svg.svg',
                                            height: 20,
                                            width: 24,
                                          ),

                                          w12,

                                          Text(
                                            getLabel(item),
                                            style: AppTextStyles.mediumCaption
                                                .copyWith(
                                                  color: AppColors.primaryText,
                                                  height: 1,
                                                ),
                                          ),
                                        ],
                                      ),

                                      h16,
                                      Divider(
                                        color: AppColors.border,
                                        height: 1,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
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

class _SavedCarItem extends StatelessWidget {
  const _SavedCarItem({
    required this.car,
    required this.onTap,
    required this.isSelected,
  });

  final UserCar car;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final carName = car.nickname?.trim().isNotEmpty == true
        ? car.nickname!.trim()
        : '${car.vehicle.brandId} - '
              '${car.vehicle.modelId} - '
              '${car.vehicle.yearId}';

    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      child: SizedBox(
        width: 72,
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.white : const Color(0xFFF4F5F6),
                border: Border.all(
                  color: isSelected ? AppColors.actionText : Colors.transparent,
                  width: 1.2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Image.asset(
                  'assets/images/car.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(height: 2),

            Text(
              carName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: AppTextStyles.mediumOverline.copyWith(
                color: AppColors.primaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
