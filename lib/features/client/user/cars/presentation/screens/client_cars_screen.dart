import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:qitai/core/constants/colors.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/core/constants/text_styles.dart';
import 'package:qitai/core/helpers/auth_required.dart';
import 'package:qitai/core/widgets/app_bar_widget.dart';
import 'package:qitai/core/widgets/empty_data_widget.dart';
import 'package:qitai/core/widgets/loading_widget.dart';
import 'package:qitai/core/widgets/page_padding.dart';
import 'package:qitai/features/client/user/cars/domain/entities/user_car.dart';
import 'package:qitai/features/client/user/cars/presentation/providers/user_car_provider.dart';

class ClientCarsScreen extends ConsumerWidget {
  const ClientCarsScreen({super.key});

  void _openAddCar(BuildContext context, WidgetRef ref) {
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userCarsAsync = ref.watch(userCarsProvider);

    return Scaffold(
      appBar: CustomAppbar(
        title: 'سياراتي',
        action: IconButton(
          padding: const EdgeInsets.all(4),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onPressed: () => _openAddCar(context, ref),
          icon: SvgPicture.asset(
            'assets/icons/profile_screens/add-circle.svg',
            width: 28,
            height: 28,
          ),
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
                onButtonPressed: () => _openAddCar(context, ref),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.only(top: 8),
              itemCount: cars.length,
              separatorBuilder: (_, _) =>
                  const Divider(height: 1, color: AppColors.border),
              itemBuilder: (context, index) {
                return _UserCarItem(
                  car: cars[index],
                  onDelete: () {
                    // DELETE
                  },
                  onEdit: () {
                    // edit
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _UserCarItem extends StatelessWidget {
  const _UserCarItem({
    required this.car,
    required this.onDelete,
    required this.onEdit,
  });

  final UserCar car;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 105,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            SizedBox(
              width: 90,
              height: 90,
              child: Image.asset('assets/images/car.png'),
            ),
            w16,

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    car.nickname?.trim().isNotEmpty == true
                        ? car.nickname!.trim()
                        : '${car.vehicle.brandId} - '
                              '${car.vehicle.modelId} - '
                              '${car.vehicle.yearId}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.mediumBody.copyWith(
                      color: AppColors.primaryText,
                    ),
                  ),
                ],
              ),
            ),

            SvgPicture.asset("assets/icons/edit-2.svg"),
            w16,

            SvgPicture.asset("assets/icons/trash.svg"),
          ],
        ),
      ),
    );
  }
}
