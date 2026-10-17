import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qitai/core/widgets/loading_widget.dart';
import 'package:qitai/features/client/home/presentation/widgets/add_car_widget.dart';
import 'package:qitai/features/client/user/cars/domain/entities/user_car.dart';

class HomeCarsSection extends StatelessWidget {
  const HomeCarsSection({
    super.key,
    required this.isAuthenticated,
    required this.userCarsAsync,
    required this.onAddCar,
    required this.onSelectCar,
  });

  final bool isAuthenticated;
  final AsyncValue<List<UserCar>>? userCarsAsync;
  final VoidCallback onAddCar;
  final ValueChanged<UserCar> onSelectCar;

  @override
  Widget build(BuildContext context) {
    if (!isAuthenticated) {
      return Padding(
        padding: const EdgeInsetsDirectional.only(start: 16),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [_buildAddCarItem()],
        ),
      );
    }

    return userCarsAsync!.when(
      loading: () =>
          const SizedBox(height: 92, child: Center(child: CustomLoading())),
      error: (error, stack) =>
          Row(textDirection: TextDirection.rtl, children: [_buildAddCarItem()]),
      data: (cars) {
        final sortedCars = [...cars]
          ..sort((a, b) {
            if (a.isDefault == b.isDefault) return 0;
            return a.isDefault ? -1 : 1;
          });

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              const SizedBox(width: 14),

              ...sortedCars.map(
                (car) => Padding(
                  padding: const EdgeInsetsDirectional.only(end: 12),
                  child: HomeCarItem(car: car, onTap: () => onSelectCar(car)),
                ),
              ),

              Padding(
                padding: const EdgeInsetsDirectional.only(end: 12),
                child: _buildAddCarItem(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAddCarItem() {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      onTap: onAddCar,
      child: const AddCar(
        img: 'assets/icons/addCar.svg',
        carName: 'اضف سيارتك',
      ),
    );
  }
}
