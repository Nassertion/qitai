import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/core/widgets/loading_widget.dart';

import 'package:qitai/features/client/user/cars/domain/entities/user_car.dart';

class UserCarCard extends StatelessWidget {
  const UserCarCard({
    super.key,
    required this.car,
    required this.isDeleting,
    required this.isSettingDefault,
    required this.onSetDefault,
    required this.onDelete,
  });

  final UserCar car;
  final bool isDeleting;
  final bool isSettingDefault;
  final VoidCallback onSetDefault;
  final VoidCallback onDelete;

  String? _attributeValue(String key) {
    for (final item in car.vehicle.attributes) {
      if (item.attribute.key == key) {
        return item.value;
      }
    }

    return null;
  }

  String get _title {
    final nickname = car.nickname?.trim();

    if (nickname != null && nickname.isNotEmpty) {
      return nickname;
    }

    return '${car.vehicle.brandId} - '
        '${car.vehicle.modelId} - '
        '${car.vehicle.yearId}';
  }

  @override
  Widget build(BuildContext context) {
    final isDefault = car.isDefault;
    final transmission = _attributeValue('transmission');
    final engine = _attributeValue('engine_capacity');

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.inputFieldAndCards,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDefault ? AppColors.actionText : AppColors.border,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 80,
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: AppColors.image,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  'assets/images/car.png',
                  fit: BoxFit.contain,
                ),
              ),
              w16,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.semiBoldCaption.copyWith(
                        color: AppColors.primaryText,
                      ),
                    ),
                    h8,
                    Text(
                      'الشاصي (VIN): ${car.vehicle.vin}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.regularOverline.copyWith(
                        color: AppColors.secondaryText,
                      ),
                    ),
                    h8,
                    Wrap(
                      spacing: 16,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        if (transmission != null)
                          _AttributeChip(
                            icon: 'assets/icons/solar_transmission-linear.svg',
                            text: transmission,
                          ),
                        if (engine != null)
                          _AttributeChip(
                            icon: 'assets/icons/Vector.svg',
                            text: '${engine}L',
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, color: AppColors.border),
          ),
          Row(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (isDefault || isSettingDefault || isDeleting)
                    ? null
                    : onSetDefault,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _DefaultRadio(
                      isSelected: isDefault,
                      isLoading: isSettingDefault,
                    ),
                    w8,
                    Text(
                      isDefault
                          ? 'سيارتي الافتراضية'
                          : 'تعيين كسيارتي الافتراضية',
                      style: AppTextStyles.mediumCaption.copyWith(
                        color: AppColors.primaryText,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              isDeleting
                  ? const CustomLoading()
                  : Padding(
                      padding: const EdgeInsets.all(12),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: onDelete,
                        child: SvgPicture.asset(
                          'assets/icons/trash.svg',
                          width: 20,
                          height: 20,
                          colorFilter: const ColorFilter.mode(
                            AppColors.errorText,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AttributeChip extends StatelessWidget {
  const _AttributeChip({required this.icon, required this.text});

  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(icon, width: 19, height: 19),
        w4,
        Text(
          text,
          style: AppTextStyles.regularOverline.copyWith(
            color: AppColors.primaryText,
          ),
        ),
      ],
    );
  }
}

class _DefaultRadio extends StatelessWidget {
  const _DefaultRadio({required this.isSelected, required this.isLoading});

  final bool isSelected;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? AppColors.actionText : AppColors.inputFieldAndCards,
        border: isSelected
            ? null
            : Border.all(color: AppColors.border, width: 1),
      ),
      child: isLoading
          ? const SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.actionText,
              ),
            )
          : isSelected
          ? const Icon(Icons.check, size: 18, color: AppColors.whiteText)
          : null,
    );
  }
}
