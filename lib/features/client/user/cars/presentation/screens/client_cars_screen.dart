import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/core/helpers/auth_required.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/core/widgets/confirmation_dialog.dart';
import 'package:qitai/core/widgets/empty_data_widget.dart';
import 'package:qitai/core/widgets/loading_widget.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/features/client/user/cars/domain/entities/user_car.dart';
import 'package:qitai/features/client/user/cars/presentation/providers/user_car_provider.dart';
import 'package:qitai/features/client/user/cars/presentation/widgets/car_status_dialog.dart';

class ClientCarsScreen extends ConsumerStatefulWidget {
  const ClientCarsScreen({super.key});

  @override
  ConsumerState<ClientCarsScreen> createState() => _ClientCarsScreenState();
}

class _ClientCarsScreenState extends ConsumerState<ClientCarsScreen> {
  final Set<int> _deletingCarIds = {};
  final Set<int> _settingDefaultCarIds = {};

  void _openAddCar(BuildContext context) {
    requireAuth(
      context: context,
      ref: ref,
      onAuthenticated: () async {
        final result = await context.push('/profile/addCar');

        if (result == true) {
          ref.invalidate(userCarsProvider);
        }
      },
    );
  }

  Future<void> _setDefaultCar(UserCar car) async {
    if (car.isDefault ||
        _settingDefaultCarIds.contains(car.id) ||
        _deletingCarIds.contains(car.id)) {
      return;
    }

    setState(() {
      _settingDefaultCarIds.add(car.id);
    });

    try {
      await ref.read(setDefaultUserCarProvider)(car.id);

      if (!mounted) {
        return;
      }

      ref.invalidate(userCarsProvider);
    } catch (e) {
      if (!mounted) {
        return;
      }

      await CarStatusDialog.show(
        context: context,
        type: CarDialogType.error,
        title: 'فشل تعيين السيارة الافتراضية',
        message: 'حدثت مشكلة ما، الرجاء المحاولة مرة أخرى.',
      );
    } finally {
      if (mounted) {
        setState(() {
          _settingDefaultCarIds.remove(car.id);
        });
      }
    }
  }

  Future<void> _deleteCar(UserCar car) async {
    if (_deletingCarIds.contains(car.id)) {
      return;
    }

    final confirmed = await ConfirmationDialog.show(
      context: context,
      title: 'حذف السيارة',
      message: 'سوف يتم حذف السيارة من مجموعة سياراتك هل أنت متأكد؟',
      confirmText: 'حذف',
    );

    if (confirmed != true || !mounted) {
      return;
    }

    setState(() {
      _deletingCarIds.add(car.id);
    });

    try {
      await ref.read(deleteUserCarProvider)(car.id);

      if (!mounted) {
        return;
      }

      ref.invalidate(userCarsProvider);

      await CarStatusDialog.show(
        context: context,
        type: CarDialogType.success,
        title: 'تم حذف السيارة بنجاح',
        message: 'تم حذف السيارة من مجموعة سياراتك.',
      );
    } catch (e) {
      if (!mounted) {
        return;
      }

      await CarStatusDialog.show(
        context: context,
        type: CarDialogType.error,
        title: 'فشلت عملية حذف السيارة',
        message: 'حدثت مشكلة ما في حذف السيارة، الرجاء المحاولة مرة أخرى.',
      );
    } finally {
      if (mounted) {
        setState(() {
          _deletingCarIds.remove(car.id);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userCarsAsync = ref.watch(userCarsProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppbar(
        title: 'سياراتي',
        action: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _AddCarButton(onTap: () => _openAddCar(context)),
        ),
      ),
      body: AppPagePadding(
        child: userCarsAsync.when(
          loading: () => const Center(child: CustomLoading()),
          error: (error, stack) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'حدث خطأ أثناء تحميل سياراتك',
                  style: AppTextStyles.mediumBody.copyWith(
                    color: AppColors.errorText,
                  ),
                ),
                h12,
                TextButton(
                  onPressed: () => ref.invalidate(userCarsProvider),
                  child: const Text('إعادة المحاولة'),
                ),
              ],
            ),
          ),
          data: (cars) {
            if (cars.isEmpty) {
              return EmptyDataWidget(
                img: 'assets/icons/profile_screens/noCar.svg',
                text: 'ليس لديك سيارات حاليًا!',
                buttonText: 'إضافة سيارة',
                onButtonPressed: () => _openAddCar(context),
              );
            }

            final sortedCars = [...cars]
              ..sort((a, b) {
                if (a.isDefault == b.isDefault) return 0;
                return a.isDefault ? -1 : 1;
              });

            return ListView.separated(
              padding: const EdgeInsets.only(top: 16, bottom: 24),
              itemCount: sortedCars.length,
              separatorBuilder: (_, _) => h16,
              itemBuilder: (context, index) {
                final car = sortedCars[index];

                return _UserCarCard(
                  car: car,
                  isDeleting: _deletingCarIds.contains(car.id),
                  isSettingDefault: _settingDefaultCarIds.contains(car.id),
                  onSetDefault: () => _setDefaultCar(car),
                  onDelete: () => _deleteCar(car),
                  onEdit: () {},
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _AddCarButton extends StatelessWidget {
  const _AddCarButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.actionText.withValues(alpha: 0.12),
        ),
        child: const Icon(Icons.add, size: 18, color: AppColors.actionText),
      ),
    );
  }
}

class _UserCarCard extends StatelessWidget {
  const _UserCarCard({
    required this.car,
    required this.isDeleting,
    required this.isSettingDefault,
    required this.onSetDefault,
    required this.onDelete,
    required this.onEdit,
  });

  final UserCar car;
  final bool isDeleting;
  final bool isSettingDefault;
  final VoidCallback onSetDefault;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

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

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: const Divider(height: 1, color: AppColors.border),
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
                          ? 'سيارتي الإفتراضية'
                          : 'تعيين كسيارتي الإفتراضية',
                      style: AppTextStyles.mediumCaption.copyWith(
                        color: AppColors.primaryText,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              Padding(
                padding: const EdgeInsets.all(12),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: isDeleting ? null : onEdit,
                  child: SvgPicture.asset(
                    'assets/icons/edit.svg',
                    width: 20,
                    height: 20,
                  ),
                ),
              ),

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
