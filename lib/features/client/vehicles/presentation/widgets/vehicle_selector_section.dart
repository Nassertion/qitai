import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qitai/core/constants/spaces.dart';
import 'package:qitai/features/client/vehicles/data/model/vehicles_model.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicles.provider.dart';
import 'package:qitai/features/client/vehicles/presentation/widgets/vehicle_filter_bottom_sheet.dart';
import 'package:qitai/features/client/vehicles/presentation/widgets/vehicle_filter_field.dart';

class VehicleSelectorSection extends ConsumerWidget {
  const VehicleSelectorSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(classificationProvider);
    final notifier = ref.read(classificationProvider.notifier);

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
      final state = ref.read(classificationProvider);
      final notifier = ref.read(classificationProvider.notifier);

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
      final state = ref.read(classificationProvider);
      final notifier = ref.read(classificationProvider.notifier);

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
        h16,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  VehicleFilterField(title: "البراند", onTap: onBrandTap),
                  if (state.selectedCarBrand != null) ...[
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
                  VehicleFilterField(title: "الموديل", onTap: onModelTap),
                  if (state.selectedModel != null) ...[
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
                  VehicleFilterField(title: "السنة", onTap: onYearTap),
                  if (state.selectedCarYear != null) ...[
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
