import 'package:qitai/features/client/vehicles/data/model/vehicles_model.dart';

class ClassificationState {
  final List<CarBrand> carBrands;
  final List<CarModel> models;
  final List<CarYear> carYears;

  final CarBrand? selectedCarBrand;
  final CarModel? selectedModel;
  final CarYear? selectedCarYear;

  final bool isBrandsLoading;
  final bool isModelsLoading;
  final bool isYearsLoading;

  final String? errorMessage;

  const ClassificationState({
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

  ClassificationState copyWith({
    List<CarBrand>? carBrands,
    List<CarModel>? models,
    List<CarYear>? carYears,
    CarBrand? selectedCarBrand,
    CarModel? selectedModel,
    CarYear? selectedCarYear,
    bool? isBrandsLoading,
    bool? isModelsLoading,
    bool? isYearsLoading,
    String? errorMessage,
    bool clearSelectedCarBrand = false,
    bool clearSelectedModel = false,
    bool clearSelectedCarYear = false,
    bool clearErrorMessage = false,
  }) {
    return ClassificationState(
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