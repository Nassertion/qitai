import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/features/client/user/cars/domain/entities/user_car.dart';
import 'package:qitai/features/client/user/cars/presentation/helper/load_saved_user_cars.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_brand.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_model.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_year.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_notifier.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_state.dart';
import 'package:qitai/features/client/vehicles/presentation/widgets/vehicle_filter_bottom_sheet.dart';
import 'package:qitai/features/client/vehicles/presentation/widgets/vehicle_filter_field.dart';

class VehicleSelectorSection extends ConsumerStatefulWidget {
  const VehicleSelectorSection({
    super.key,
    this.inlineSelection = false,
    this.useAddCarProvider = false,
  });

  final bool inlineSelection;
  final bool useAddCarProvider;

  @override
  ConsumerState<VehicleSelectorSection> createState() =>
      _VehicleSelectorSectionState();
}

class _VehicleSelectorSectionState
    extends ConsumerState<VehicleSelectorSection> {
  int? _selectedSavedCarId;

  VehicleScope get _scope =>
      widget.useAddCarProvider ? VehicleScope.addCar : VehicleScope.browse;

  VehicleNotifier get _notifier => ref.read(vehicleProvider(_scope).notifier);

  VehicleState _readVehicleState() => ref.read(vehicleProvider(_scope));

  void _clearSavedCarSelection() {
    if (_selectedSavedCarId == null) return;

    setState(() {
      _selectedSavedCarId = null;
    });
  }

  void _selectSavedCar(UserCar car) {
    if (!mounted || widget.useAddCarProvider) return;

    setState(() {
      _selectedSavedCarId = car.id;
    });

    unawaited(
      _notifier.selectVehicleByIds(
        brandId: car.vehicle.brandId,
        modelId: car.vehicle.modelId,
        yearId: car.vehicle.yearId,
      ),
    );
  }

  Future<void> _showBrandFilter(BuildContext context) async {
    final savedCars = widget.useAddCarProvider
        ? <UserCar>[]
        : await loadSavedUserCars(ref);

    if (!mounted || !context.mounted) return;

    final state = _readVehicleState();

    await VehicleFilterBottomSheet.show<CarBrand>(
      context: context,
      items: state.carBrands,
      title: 'اختر نوع البراند',
      getLabel: (item) => item.name,
      savedCars: savedCars,
      selectedCarId: widget.useAddCarProvider ? null : _selectedSavedCarId,
      onUserCarSelected: widget.useAddCarProvider ? null : _selectSavedCar,
      onSelected: (value) {
        _clearSavedCarSelection();
        unawaited(_notifier.selectBrand(value));
      },
    );
  }

  void _showModelFilter(BuildContext context) {
    final state = _readVehicleState();

    final selectedBrand = state.selectedCarBrand;
    if (selectedBrand == null || state.isModelsLoading) return;

    unawaited(
      VehicleFilterBottomSheet.show<CarModel>(
        context: context,
        items: state.models,
        title: 'اختر الموديل',
        getLabel: (item) => item.name,
        onRetry: () => _notifier.selectBrand(selectedBrand),
        onSelected: (value) {
          _clearSavedCarSelection();
          unawaited(_notifier.selectModel(value));
        },
      ),
    );
  }

  void _showYearFilter(BuildContext context) {
    final state = _readVehicleState();

    final selectedModel = state.selectedModel;
    if (selectedModel == null || state.isYearsLoading) return;

    unawaited(
      VehicleFilterBottomSheet.show<CarYear>(
        context: context,
        items: state.carYears,
        title: 'اختر السنة',
        getLabel: (item) => item.year.toString(),
        onRetry: () => _notifier.selectModel(selectedModel),
        onSelected: (value) {
          _clearSavedCarSelection();
          _notifier.selectCarYear(value);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(vehicleProvider(_scope));
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
                  if (!inlineSelection && state.selectedCarBrand != null) ...[
                    const SizedBox(height: 8),
                    VehicleFilterField(
                      title: state.selectedCarBrand!.name,
                      isSelectedStyle: true,
                      onDelete: () {
                        _clearSavedCarSelection();
                        _notifier.clearBrand();
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
                        _notifier.clearModel();
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
                  if (!inlineSelection && state.selectedCarYear != null) ...[
                    const SizedBox(height: 8),
                    VehicleFilterField(
                      title: state.selectedCarYear!.year.toString(),
                      isSelectedStyle: true,
                      onDelete: () {
                        _clearSavedCarSelection();
                        _notifier.clearYear();
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
