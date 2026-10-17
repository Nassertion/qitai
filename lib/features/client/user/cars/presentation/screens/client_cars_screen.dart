import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/features/client/auth/presentation/helper/auth_required.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/core/widgets/confirmation_dialog.dart';
import 'package:qitai/core/widgets/empty_data_widget.dart';
import 'package:qitai/core/widgets/loading_widget.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/features/client/auth/presentation/providers/auth_notifier.dart';
import 'package:qitai/features/client/auth/presentation/providers/auth_state.dart';
import 'package:qitai/features/client/user/cars/domain/entities/user_car.dart';
import 'package:qitai/features/client/user/cars/presentation/providers/user_car_provider.dart';
import 'package:qitai/features/client/user/cars/presentation/widgets/car_status_dialog.dart';
import 'package:qitai/features/client/user/cars/presentation/widgets/user_car_card.dart';

class ClientCarsScreen extends ConsumerStatefulWidget {
  const ClientCarsScreen({super.key});

  @override
  ConsumerState<ClientCarsScreen> createState() => _ClientCarsScreenState();
}

class _ClientCarsScreenState extends ConsumerState<ClientCarsScreen> {
  final Set<int> _deletingCarIds = {};
  final Set<int> _settingDefaultCarIds = {};

  bool _hasAccess = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_ensureAuthenticated());
    });
  }

  Future<void> _ensureAuthenticated() async {
    await requireAuth(
      context: context,
      ref: ref,
      onAuthenticated: () {
        if (!mounted) return;

        setState(() {
          _hasAccess = true;
        });
      },
    );

    if (!mounted) return;

    if (ref.read(authProvider) is Authenticated) {
      return;
    }

    // إذا أغلق المستخدم نافذة المصادقة دون تسجيل الدخول،
    // نمنعه من البقاء في صفحة السيارات.
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/');
    }
  }

  void _openAddCar(BuildContext context) {
    requireAuth(
      context: context,
      ref: ref,
      onAuthenticated: () async {
        final result = await context.push('/profile/addCar');

        if (!mounted) return;

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

      if (!mounted) return;

      ref.invalidate(userCarsProvider);
    } catch (e) {
      if (!mounted) return;

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

      if (!mounted) return;

      ref.invalidate(userCarsProvider);

      await CarStatusDialog.show(
        context: context,
        type: CarDialogType.success,
        title: 'تم حذف السيارة بنجاح',
        message: 'تم حذف السيارة من مجموعة سياراتك.',
      );
    } catch (e) {
      if (!mounted) return;

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
    // لا نحمّل سيارات المستخدم قبل التأكد من تسجيل دخوله.
    if (!_hasAccess) {
      return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: const CustomAppbar(title: 'سياراتي'),
        body: const Center(child: CustomLoading()),
      );
    }

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
                  onPressed: () {
                    ref.invalidate(userCarsProvider);
                  },
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

                return UserCarCard(
                  car: car,
                  isDeleting: _deletingCarIds.contains(car.id),
                  isSettingDefault: _settingDefaultCarIds.contains(car.id),
                  onSetDefault: () => _setDefaultCar(car),
                  onDelete: () => _deleteCar(car),
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
