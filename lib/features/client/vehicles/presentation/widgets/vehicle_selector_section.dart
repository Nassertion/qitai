import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/features/client/auth/presentation/providers/auth_notifier.dart';
import 'package:qitai/features/client/auth/presentation/providers/auth_state.dart';
import 'package:qitai/features/client/user/cars/domain/entities/user_car.dart';
import 'package:qitai/features/client/user/cars/presentation/providers/user_car_provider.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_brand.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_model.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_year.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_notifier.dart';
import 'package:qitai/features/client/vehicles/presentation/widgets/vehicle_filter_bottom_sheet.dart';
import 'package:qitai/features/client/vehicles/presentation/widgets/vehicle_filter_field.dart';

class VehicleSelectorSection extends ConsumerStatefulWidget {
  final bool inlineSelection;

  const VehicleSelectorSection({
    super.key,
    this.inlineSelection = false,
  });

  @override
  ConsumerState<VehicleSelectorSection> createState() =>
      _VehicleSelectorSectionState();
}

class _VehicleSelectorSectionState
    extends ConsumerState<VehicleSelectorSection> {
  int? _selectedSavedCarId;

  void _clearSavedCarSelection() {
    setState(() {
      _selectedSavedCarId = null;
    });
  }

  List<UserCar> _sortCars(List<UserCar> cars) {
    final sortedCars = [...cars]
      ..sort(
        (a, b) => (b.isDefault ? 1 : 0).compareTo(
          a.isDefault ? 1 : 0,
        ),
      );

    return sortedCars;
  }

  Future<List<UserCar>> _loadSavedCars() async {
    if (ref.read(authProvider) is! Authenticated) {
      return const [];
    }

    final cachedCars = ref.read(userCarsProvider).asData?.value;

    if (cachedCars != null) {
      return _sortCars(cachedCars);
    }

    try {
      final cars = await ref.read(userCarsProvider.future);
      return _sortCars(cars);
    } catch (_) {
      return const [];
    }
  }

  void _selectSavedCar(UserCar car) {
    setState(() {
      _selectedSavedCarId = car.id;
    });

    unawaited(
      ref.read(vehicleProvider.notifier).selectVehicleByIds(
            brandId: car.vehicle.brandId,
            modelId: car.vehicle.modelId,
            yearId: car.vehicle.yearId,
          ),
    );
  }

  Future<void> _showBrandFilter(
    BuildContext context,
  ) async {
    final state = ref.read(vehicleProvider);
    final notifier = ref.read(vehicleProvider.notifier);

    final savedCars = await _loadSavedCars();

    if (!mounted || !context.mounted) return;

    await VehicleFilterBottomSheet.show<CarBrand>(
      context: context,
      items: state.carBrands,
      title: 'اختر نوع البراند',
      getLabel: (item) => item.name,
      savedCars: savedCars,
      selectedCarId: _selectedSavedCarId,
      onUserCarSelected: _selectSavedCar,
      onSelected: (value) {
        _clearSavedCarSelection();
        unawaited(notifier.selectBrand(value));
      },
    );
  }

  void _showModelFilter(BuildContext context) {
    final state = ref.read(vehicleProvider);
    final notifier = ref.read(vehicleProvider.notifier);

    if (state.selectedCarBrand == null) return;
    if (state.isModelsLoading) return;

    VehicleFilterBottomSheet.show<CarModel>(
      context: context,
      items: state.models,
      title: 'اختر الموديل',
      getLabel: (item) => item.name,
      onRetry: () async {
        await notifier.selectBrand(state.selectedCarBrand!);
      },
      onSelected: (value) {
        _clearSavedCarSelection();
        unawaited(notifier.selectModel(value));
      },
    );
  }

  void _showYearFilter(BuildContext context) {
    final state = ref.read(vehicleProvider);
    final notifier = ref.read(vehicleProvider.notifier);

    if (state.selectedModel == null) return;
    if (state.isYearsLoading) return;

    VehicleFilterBottomSheet.show<CarYear>(
      context: context,
      items: state.carYears,
      title: 'اختر السنة',
      getLabel: (item) => item.year.toString(),
      onRetry: () async {
        await notifier.selectModel(state.selectedModel!);
      },
      onSelected: (value) {
        _clearSavedCarSelection();
        notifier.selectCarYear(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(vehicleProvider);
    final notifier = ref.read(vehicleProvider.notifier);
    final inlineSelection = widget.inlineSelection;

    return Column(
      children: [
        if (!inlineSelection) h16,

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  VehicleFilterField(
                    title: inlineSelection
                        ? (state.selectedCarBrand?.name ?? 'البراند')
                        : 'البراند',
                    isValueSelected:
                        inlineSelection && state.selectedCarBrand != null,
                    onTap: () => _showBrandFilter(context),
                  ),

                  if (!inlineSelection &&
                      state.selectedCarBrand != null) ...[
                    const SizedBox(height: 8),
                    VehicleFilterField(
                      title: state.selectedCarBrand!.name,
                      isSelectedStyle: true,
                      onDelete: () {
                        _clearSavedCarSelection();
                        notifier.clearBrand();
                      },
                    ),
                  ],
                ],
              ),
            ),

            Expanded(
              child: Column(
                children: [
                  VehicleFilterField(
                    title: inlineSelection
                        ? (state.selectedModel?.name ?? 'الموديل')
                        : 'الموديل',
                    isValueSelected:
                        inlineSelection && state.selectedModel != null,
                    onTap: () => _showModelFilter(context),
                  ),

                  if (!inlineSelection && state.selectedModel != null) ...[
                    const SizedBox(height: 8),
                    VehicleFilterField(
                      title: state.selectedModel!.name,
                      isSelectedStyle: true,
                      onDelete: () {
                        _clearSavedCarSelection();
                        notifier.clearModel();
                      },
                    ),
                  ],
                ],
              ),
            ),

            Expanded(
              child: Column(
                children: [
                  VehicleFilterField(
                    title: inlineSelection
                        ? (state.selectedCarYear?.year.toString() ?? 'السنة')
                        : 'السنة',
                    isValueSelected:
                        inlineSelection && state.selectedCarYear != null,
                    onTap: () => _showYearFilter(context),
                  ),

                  if (!inlineSelection &&
                      state.selectedCarYear != null) ...[
                    const SizedBox(height: 8),
                    VehicleFilterField(
                      title: state.selectedCarYear!.year.toString(),
                      isSelectedStyle: true,
                      onDelete: () {
                        _clearSavedCarSelection();
                        notifier.clearYear();
                      },
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}