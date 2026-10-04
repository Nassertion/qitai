import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_brand.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_model.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_year.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_notifier.dart';
import 'package:qitai/features/client/vehicles/presentation/widgets/vehicle_filter_bottom_sheet.dart';
import 'package:qitai/features/client/vehicles/presentation/widgets/vehicle_filter_field.dart';

class VehicleSelectorSection extends ConsumerWidget {
  final bool inlineSelection;

  const VehicleSelectorSection({super.key, this.inlineSelection = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(vehicleProvider);
    final notifier = ref.read(vehicleProvider.notifier);

    void onBrandTap() {
      VehicleFilterBottomSheet.show<CarBrand>(
        context: context,
        items: state.carBrands,
        title: 'اختر نوع البراند',
        getLabel: (item) => item.name,
        onSelected: (value) async {
          await notifier.selectBrand(value);
        },
      );
    }

    void onModelTap() {
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
        onSelected: (value) async {
          await notifier.selectModel(value);
        },
      );
    }

    void onYearTap() {
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
          notifier.selectCarYear(value);
        },
      );
    }

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
                    onTap: onBrandTap,
                  ),

                  if (!inlineSelection && state.selectedCarBrand != null) ...[
                    const SizedBox(height: 8),
                    VehicleFilterField(
                      title: state.selectedCarBrand!.name,
                      isSelectedStyle: true,
                      onDelete: notifier.clearBrand,
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
                    onTap: onModelTap,
                  ),

                  if (!inlineSelection && state.selectedModel != null) ...[
                    const SizedBox(height: 8),
                    VehicleFilterField(
                      title: state.selectedModel!.name,
                      isSelectedStyle: true,
                      onDelete: notifier.clearModel,
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
                    onTap: onYearTap,
                  ),

                  if (!inlineSelection && state.selectedCarYear != null) ...[
                    const SizedBox(height: 8),
                    VehicleFilterField(
                      title: state.selectedCarYear!.year.toString(),
                      isSelectedStyle: true,
                      onDelete: notifier.clearYear,
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
