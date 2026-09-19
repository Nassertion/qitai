import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_state.dart';

bool hasVehicleFiltersChanged(
  VehicleState? previous,
  VehicleState next,
) {
  final prevBrandId = previous?.selectedCarBrand?.id;
  final nextBrandId = next.selectedCarBrand?.id;

  final prevModelId = previous?.selectedModel?.id;
  final nextModelId = next.selectedModel?.id;

  final prevYear = previous?.selectedCarYear?.year;
  final nextYear = next.selectedCarYear?.year;

  return prevBrandId != nextBrandId ||
      prevModelId != nextModelId ||
      prevYear != nextYear;
}