import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/features/client/user/cars/domain/entities/user_car.dart';

class AddCar extends StatelessWidget {
  final String img;
  final String carName;

  const AddCar({super.key, required this.img, required this.carName});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 64,
          width: 64,
          child: CircleAvatar(
            backgroundColor: AppColors.backgroundColor,
            child: SvgPicture.asset(img),
          ),
        ),
        h4,
        Text(
          carName,
          style: AppTextStyles.mediumOverline.copyWith(
            color: AppColors.primaryText,
          ),
        ),
      ],
    );
  }
}

class HomeCarItem extends StatelessWidget {
  final UserCar car;
  final VoidCallback? onTap;

  const HomeCarItem({super.key, required this.car, this.onTap});

  @override
  Widget build(BuildContext context) {
    final carName = car.nickname?.trim().isNotEmpty == true
        ? car.nickname!.trim()
        : '${car.vehicle.brandId} - '
              '${car.vehicle.modelId} - '
              '${car.vehicle.yearId}';

    return InkWell(
      onTap: car.isDefault ? null : onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      child: SizedBox(
        // width: 72,
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: car.isDefault
                    ? AppColors.backgroundColor
                    : AppColors.image,
                border: Border.all(
                  color: car.isDefault
                      ? AppColors.actionText
                      : Colors.transparent,
                  width: 2,
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
            h4,
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
