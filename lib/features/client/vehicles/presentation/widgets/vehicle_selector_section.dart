import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/features/client/auth/presentation/providers/auth_notifier.dart';
import 'package:qitai/features/client/auth/presentation/providers/auth_state.dart';
import 'package:qitai/features/client/user/cars/domain/entities/user_car.dart';
import 'package:qitai/features/client/user/cars/presentation/providers/add_car_vehicle_notifier.dart';
import 'package:qitai/features/client/user/cars/presentation/providers/user_car_provider.dart';
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

  // # Read Current Vehicle State
  VehicleState _readVehicleState() {
    if (widget.useAddCarProvider) {
      return ref.read(addCarVehicleProvider);
    }

    return ref.read(vehicleProvider);
  }

  // # Watch Vehicle State Inside Bottom Sheet
  VehicleState _watchVehicleState(WidgetRef sheetRef) {
    if (widget.useAddCarProvider) {
      return sheetRef.watch(addCarVehicleProvider);
    }

    return sheetRef.watch(vehicleProvider);
  }

  // # Load Brands
  Future<void> _loadBrands() {
    if (widget.useAddCarProvider) {
      return ref.read(addCarVehicleProvider.notifier).loadBrands();
    }

    return ref.read(vehicleProvider.notifier).loadBrands();
  }

  // # Ensure Brands Are Available
  void _ensureBrandsLoaded() {
    final state = _readVehicleState();

    if (state.carBrands.isNotEmpty || state.isBrandsLoading) {
      return;
    }

    unawaited(_loadBrands());
  }

  // # Select Brand
  Future<void> _selectBrand(CarBrand brand) {
    if (widget.useAddCarProvider) {
      return ref.read(addCarVehicleProvider.notifier).selectBrand(brand);
    }

    return ref.read(vehicleProvider.notifier).selectBrand(brand);
  }

  // # Select Model
  Future<void> _selectModel(CarModel model) {
    if (widget.useAddCarProvider) {
      return ref.read(addCarVehicleProvider.notifier).selectModel(model);
    }

    return ref.read(vehicleProvider.notifier).selectModel(model);
  }

  // # Select Year
  void _selectYear(CarYear year) {
    if (widget.useAddCarProvider) {
      ref.read(addCarVehicleProvider.notifier).selectCarYear(year);
    } else {
      ref.read(vehicleProvider.notifier).selectCarYear(year);
    }
  }

  // # Clear Brand
  void _clearBrand() {
    if (widget.useAddCarProvider) {
      ref.read(addCarVehicleProvider.notifier).clearBrand();
    } else {
      ref.read(vehicleProvider.notifier).clearBrand();
    }
  }

  // # Clear Model
  void _clearModel() {
    if (widget.useAddCarProvider) {
      ref.read(addCarVehicleProvider.notifier).clearModel();
    } else {
      ref.read(vehicleProvider.notifier).clearModel();
    }
  }

  // # Clear Year
  void _clearYear() {
    if (widget.useAddCarProvider) {
      ref.read(addCarVehicleProvider.notifier).clearYear();
    } else {
      ref.read(vehicleProvider.notifier).clearYear();
    }
  }

  // # Clear Saved Car Selection
  void _clearSavedCarSelection() {
    if (!mounted || _selectedSavedCarId == null) return;

    setState(() {
      _selectedSavedCarId = null;
    });
  }

  // # Sort Saved Cars
  List<UserCar> _sortCars(List<UserCar> cars) {
    final sortedCars = [...cars]
      ..sort((a, b) => (b.isDefault ? 1 : 0).compareTo(a.isDefault ? 1 : 0));

    return sortedCars;
  }

  // # Load Saved Cars
  Future<List<UserCar>> _loadSavedCars() async {
    if (widget.useAddCarProvider) {
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
    if (!mounted || widget.useAddCarProvider) return;

    setState(() {
      _selectedSavedCarId = car.id;
    });

    unawaited(
      ref
          .read(vehicleProvider.notifier)
          .selectVehicleByIds(
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

    final state = _readVehicleState();

    await VehicleFilterBottomSheet.show<CarBrand>(
      context: context,
      items: state.carBrands,
      title: 'اختر نوع البراند',
      getLabel: (item) => item.name,

      // # Live Brand State
      watchItems: (sheetRef) => _watchVehicleState(sheetRef).carBrands,
      watchLoading: (sheetRef) => _watchVehicleState(sheetRef).isBrandsLoading,
      watchError: (sheetRef) => _watchVehicleState(sheetRef).errorMessage,

      // # Retry Without Closing
      onRetry: () {
        if (!mounted) return;
        unawaited(_loadBrands());
      },

      savedCars: savedCars,
      selectedCarId: widget.useAddCarProvider ? null : _selectedSavedCarId,
      onUserCarSelected: widget.useAddCarProvider ? null : _selectSavedCar,

      // # Select Brand
      onSelected: (value) {
        if (!mounted) return;

        _clearSavedCarSelection();
        unawaited(_selectBrand(value));
      },
    );
  }

  // # Model Filter
  void _showModelFilter(BuildContext context) {
    final state = _readVehicleState();

    if (state.selectedCarBrand == null) return;

    unawaited(
      VehicleFilterBottomSheet.show<CarModel>(
        context: context,
        items: state.models,
        title: 'اختر الموديل',
        getLabel: (item) => item.name,

        // # Live Model State
        watchItems: (sheetRef) => _watchVehicleState(sheetRef).models,
        watchLoading: (sheetRef) =>
            _watchVehicleState(sheetRef).isModelsLoading,
        watchError: (sheetRef) => _watchVehicleState(sheetRef).errorMessage,

        // # Retry Current Brand
        onRetry: () {
          if (!mounted) return;

          final brand = _readVehicleState().selectedCarBrand;
          if (brand == null) return;

          unawaited(_selectBrand(brand));
        },

        // # Select Model
        onSelected: (value) {
          if (!mounted) return;

          _clearSavedCarSelection();
          unawaited(_selectModel(value));
        },
      ),
    );
  }

  // # Year Filter
  void _showYearFilter(BuildContext context) {
    final state = _readVehicleState();

    if (state.selectedModel == null) return;

    unawaited(
      VehicleFilterBottomSheet.show<CarYear>(
        context: context,
        items: state.carYears,
        title: 'اختر السنة',
        getLabel: (item) => item.year.toString(),

        // # Live Year State
        watchItems: (sheetRef) => _watchVehicleState(sheetRef).carYears,
        watchLoading: (sheetRef) => _watchVehicleState(sheetRef).isYearsLoading,
        watchError: (sheetRef) => _watchVehicleState(sheetRef).errorMessage,

        // # Retry Current Model
        onRetry: () {
          if (!mounted) return;

          final model = _readVehicleState().selectedModel;
          if (model == null) return;

          unawaited(_selectModel(model));
        },

        // # Select Year
        onSelected: (value) {
          if (!mounted) return;

          _clearSavedCarSelection();
          _selectYear(value);
        },
      ),
    );
  }

  // # Build
  @override
  Widget build(BuildContext context) {
    final state = widget.useAddCarProvider
        ? ref.watch(addCarVehicleProvider)
        : ref.watch(vehicleProvider);

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
                        inlineSelection && state.selectedCarBrand != null,
                    onTap: () {
                      unawaited(_showBrandFilter(context));
                    },
                  ),

                  if (!inlineSelection && state.selectedCarBrand != null) ...[
                    const SizedBox(height: 8),
                    VehicleFilterField(
                      title: state.selectedCarBrand!.name,
                      isSelectedStyle: true,
                      onDelete: () {
                        _clearSavedCarSelection();
                        _clearBrand();
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

                  if (!inlineSelection && state.selectedModel != null) ...[
                    const SizedBox(height: 8),
                    VehicleFilterField(
                      title: state.selectedModel!.name,
                      isSelectedStyle: true,
                      onDelete: () {
                        _clearSavedCarSelection();
                        _clearModel();
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
                        _clearYear();
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
