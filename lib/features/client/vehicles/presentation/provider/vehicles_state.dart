import 'package:qitai/features/client/vehicles/data/model/vehicles_model1.dart';

class VehicleState {
  final List<CarBrand1> carBrands;
  final List<CarModel1> models;
  final List<CarYear1> carYears;

  final CarBrand1? selectedCarBrand;
  final CarModel1? selectedModel;
  final CarYear1? selectedCarYear;

  final bool isBrandsLoading;
  final bool isModelsLoading;
  final bool isYearsLoading;

  final String? errorMessage;

  const VehicleState({
    this.carBrands = const [],
    this.models = const [],
    this.carYears = const [],
    this.selectedCarBrand,
    this.selectedModel,
    this.selectedCarYear,
    this.isBrandsLoading = false,
    this.isModelsLoading = false,
    this.isYearsLoading = false,
    this.errorMessage,
  });

  VehicleState copyWith({
    List<CarBrand1>? carBrands,
    List<CarModel1>? models,
    List<CarYear1>? carYears,
    CarBrand1? selectedCarBrand,
    CarModel1? selectedModel,
    CarYear1? selectedCarYear,
    bool? isBrandsLoading,
    bool? isModelsLoading,
    bool? isYearsLoading,
    String? errorMessage,
    bool clearSelectedCarBrand = false,
    bool clearSelectedModel = false,
    bool clearSelectedCarYear = false,
    bool clearErrorMessage = false,
  }) {
    return VehicleState(
      carBrands: carBrands ?? this.carBrands,
      models: models ?? this.models,
      carYears: carYears ?? this.carYears,
      selectedCarBrand: clearSelectedCarBrand
          ? null
          : (selectedCarBrand ?? this.selectedCarBrand),
      selectedModel:
          clearSelectedModel ? null : (selectedModel ?? this.selectedModel),
      selectedCarYear: clearSelectedCarYear
          ? null
          : (selectedCarYear ?? this.selectedCarYear),
      isBrandsLoading: isBrandsLoading ?? this.isBrandsLoading,
      isModelsLoading: isModelsLoading ?? this.isModelsLoading,
      isYearsLoading: isYearsLoading ?? this.isYearsLoading,
      errorMessage:
          clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }
}