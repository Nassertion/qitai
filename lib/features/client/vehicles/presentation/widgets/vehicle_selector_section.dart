
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
  const VehicleSelectorSection({
    super.key,
    this.inlineSelection = false,
  });

  final bool inlineSelection;

  @override
  ConsumerState<VehicleSelectorSection> createState() =>
      _VehicleSelectorSectionState();
}

class _VehicleSelectorSectionState
    extends ConsumerState<VehicleSelectorSection> {
  int? _selectedSavedCarId;

  // # Clear Saved Car Selection
  void _clearSavedCarSelection() {
    if (!mounted || _selectedSavedCarId == null) return;

    setState(() {
      _selectedSavedCarId = null;
    });
  }

  // # Ensure Brands Are Loaded
  void _ensureBrandsLoaded() {
    final state = ref.read(vehicleProvider);

    if (state.carBrands.isNotEmpty || state.isBrandsLoading) {
      return;
    }

    unawaited(
      ref.read(vehicleProvider.notifier).loadBrands(),
    );
  }

  // # Sort Saved Cars
  List<UserCar> _sortCars(List<UserCar> cars) {
    final sortedCars = [...cars]
      ..sort(
        (a, b) => (b.isDefault ? 1 : 0).compareTo(
          a.isDefault ? 1 : 0,
        ),
      );

    return sortedCars;
  }

  // # Load Saved Cars
  Future<List<UserCar>> _loadSavedCars() async {
    // # Only Show Saved Cars In Filter Mode
    if (widget.inlineSelection) {
      return const [];
    }

    if (ref.read(authProvider) is! Authenticated) {
      return const [];
    }

    final cachedCars = ref.read(userCarsProvider).asData?.value;

    if (cachedCars != null) {
      return _sortCars(cachedCars);
    }

    try {
      final cars = await ref.read(userCarsProvider.future);

      if (!mounted) return const [];

      return _sortCars(cars);
    } catch (_) {
      return const [];
    }
  }

  // # Select Saved Car
  void _selectSavedCar(UserCar car) {
    if (!mounted || widget.inlineSelection) return;

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

  // # Brand Filter
  Future<void> _showBrandFilter(BuildContext context) async {
    // # Handle Fast User Tap
    _ensureBrandsLoaded();

    final savedCars = await _loadSavedCars();

    if (!mounted || !context.mounted) return;

    await VehicleFilterBottomSheet.show<CarBrand>(
      context: context,
      items: ref.read(vehicleProvider).carBrands,
      title: 'اختر نوع البراند',
      getLabel: (item) => item.name,

      // # Live Brand Data
      watchItems: (sheetRef) =>
          sheetRef.watch(vehicleProvider).carBrands,
      watchLoading: (sheetRef) =>
          sheetRef.watch(vehicleProvider).isBrandsLoading,
      watchError: (sheetRef) =>
          sheetRef.watch(vehicleProvider).errorMessage,

      // # Retry
      onRetry: () {
        if (!mounted) return;

        unawaited(
          ref.read(vehicleProvider.notifier).loadBrands(),
        );
      },

      savedCars: savedCars,
      selectedCarId: widget.inlineSelection
          ? null
          : _selectedSavedCarId,
      onUserCarSelected:
          widget.inlineSelection ? null : _selectSavedCar,

      // # Select Brand
      onSelected: (value) {
        if (!mounted) return;

        _clearSavedCarSelection();

        unawaited(
          ref.read(vehicleProvider.notifier).selectBrand(value),
        );
      },
    );
  }

  // # Model Filter
  void _showModelFilter(BuildContext context) {
    final state = ref.read(vehicleProvider);

    if (state.selectedCarBrand == null) return;

    unawaited(
      VehicleFilterBottomSheet.show<CarModel>(
        context: context,
        items: state.models,
        title: 'اختر الموديل',
        getLabel: (item) => item.name,

        // # Live Model Data
        watchItems: (sheetRef) =>
            sheetRef.watch(vehicleProvider).models,
        watchLoading: (sheetRef) =>
            sheetRef.watch(vehicleProvider).isModelsLoading,
        watchError: (sheetRef) =>
            sheetRef.watch(vehicleProvider).errorMessage,

        // # Retry Current Brand
        onRetry: () {
          if (!mounted) return;

          final brand = ref.read(vehicleProvider).selectedCarBrand;

          if (brand == null) return;

          unawaited(
            ref.read(vehicleProvider.notifier).selectBrand(brand),
          );
        },

        // # Select Model
        onSelected: (value) {
          if (!mounted) return;

          _clearSavedCarSelection();

          unawaited(
            ref.read(vehicleProvider.notifier).selectModel(value),
          );
        },
      ),
    );
  }

  // # Year Filter
  void _showYearFilter(BuildContext context) {
    final state = ref.read(vehicleProvider);

    if (state.selectedModel == null) return;

    unawaited(
      VehicleFilterBottomSheet.show<CarYear>(
        context: context,
        items: state.carYears,
        title: 'اختر السنة',
        getLabel: (item) => item.year.toString(),

        // # Live Year Data
        watchItems: (sheetRef) =>
            sheetRef.watch(vehicleProvider).carYears,
        watchLoading: (sheetRef) =>
            sheetRef.watch(vehicleProvider).isYearsLoading,
        watchError: (sheetRef) =>
            sheetRef.watch(vehicleProvider).errorMessage,

        // # Retry Current Model
        onRetry: () {
          if (!mounted) return;

          final model = ref.read(vehicleProvider).selectedModel;

          if (model == null) return;

          unawaited(
            ref.read(vehicleProvider.notifier).selectModel(model),
          );
        },

        // # Select Year
        onSelected: (value) {
          if (!mounted) return;

          _clearSavedCarSelection();

          ref.read(vehicleProvider.notifier).selectCarYear(value);
        },
      ),
    );
  }

  // # Build
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
            // # Brand Field
            Expanded(
              child: Column(
                children: [
                  VehicleFilterField(
                    title: inlineSelection
                        ? (state.selectedCarBrand?.name ?? 'البراند')
                        : 'البراند',
                    isValueSelected:
                        inlineSelection &&
                        state.selectedCarBrand != null,
                    onTap: () {
                      unawaited(_showBrandFilter(context));
                    },
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

            // # Model Field
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

                  if (!inlineSelection &&
                      state.selectedModel != null) ...[
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

            // # Year Field
            Expanded(
              child: Column(
                children: [
                  VehicleFilterField(
                    title: inlineSelection
                        ? (state.selectedCarYear?.year.toString() ?? 'السنة')
                        : 'السنة',
                    isValueSelected:
                        inlineSelection &&
                        state.selectedCarYear != null,
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
