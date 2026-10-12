import 'package:qitai/features/client/vehicles/domain/entities/car_brand.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_model.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_year.dart';
import 'package:qitai/features/client/vehicles/domain/usecases/get_car_brand.dart';
import 'package:qitai/features/client/vehicles/domain/usecases/get_car_models.dart';
import 'package:qitai/features/client/vehicles/domain/usecases/get_car_years.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_provider.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vehicles_notifier.g.dart';

@riverpod
class VehicleNotifier extends _$VehicleNotifier {
  late final GetCarBrands getCarBrands;
  late final GetCarModels getCarModels;
  late final GetCarYears getCarYears;

  @override
  VehicleState build() {
    getCarBrands = ref.read(getCarBrandsProvider);
    getCarModels = ref.read(getCarModelsProvider);
    getCarYears = ref.read(getCarYearsProvider);

    return const VehicleState();
  }

  Future<void> loadBrands() async {
    state = state.copyWith(
      isBrandsLoading: true,
      clearErrorMessage: true,
    );

    try {
      final brands = await getCarBrands();

      state = state.copyWith(
        carBrands: brands,
        isBrandsLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isBrandsLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> selectBrand(CarBrand carBrand) async {
    state = state.copyWith(
      selectedCarBrand: carBrand,
      clearSelectedModel: true,
      clearSelectedCarYear: true,
      models: [],
      carYears: [],
      isModelsLoading: true,
      clearErrorMessage: true,
    );

    try {
      final models = await getCarModels(carBrand.id);

      state = state.copyWith(
        models: models,
        isModelsLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isModelsLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> selectModel(CarModel model) async {
    state = state.copyWith(
      selectedModel: model,
      clearSelectedCarYear: true,
      carYears: [],
      isYearsLoading: true,
      clearErrorMessage: true,
    );

    try {
      final years = await getCarYears(model.id);

      state = state.copyWith(
        carYears: years,
        isYearsLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isYearsLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  void selectCarYear(CarYear carYear) {
    state = state.copyWith(selectedCarYear: carYear);
  }

  void clearBrand() {
    state = state.copyWith(
      clearSelectedCarBrand: true,
      clearSelectedModel: true,
      clearSelectedCarYear: true,
      models: [],
      carYears: [],
    );
  }

  void clearModel() {
    state = state.copyWith(
      clearSelectedModel: true,
      clearSelectedCarYear: true,
      carYears: [],
    );
  }

  void clearYear() {
    state = state.copyWith(clearSelectedCarYear: true);
  }

  void clearAll() {
    state = state.copyWith(
      clearSelectedCarBrand: true,
      clearSelectedModel: true,
      clearSelectedCarYear: true,
      models: [],
      carYears: [],
      isModelsLoading: false,
      isYearsLoading: false,
      clearErrorMessage: true,
    );
  }
  Future<void> selectVehicleByIds({
  required int brandId,
  required int modelId,
  required int yearId,
}) async {
  state = state.copyWith(
    isBrandsLoading: true,
    isModelsLoading: true,
    isYearsLoading: true,
    clearErrorMessage: true,
  );

  try {
    final brands = await getCarBrands();

    CarBrand? selectedBrand;

    for (final brand in brands) {
      if (brand.id == brandId) {
        selectedBrand = brand;
        break;
      }
    }

    if (selectedBrand == null) {
      throw Exception('لم يتم العثور على البراند.');
    }

    final models = await getCarModels(brandId);

    CarModel? selectedModel;

    for (final model in models) {
      if (model.id == modelId) {
        selectedModel = model;
        break;
      }
    }

    if (selectedModel == null) {
      throw Exception('لم يتم العثور على الموديل.');
    }

    final years = await getCarYears(modelId);

    CarYear? selectedYear;

    for (final year in years) {
      if (year.id == yearId) {
        selectedYear = year;
        break;
      }
    }

    if (selectedYear == null) {
      throw Exception('لم يتم العثور على السنة.');
    }

    state = state.copyWith(
      carBrands: brands,
      models: models,
      carYears: years,
      selectedCarBrand: selectedBrand,
      selectedModel: selectedModel,
      selectedCarYear: selectedYear,
      isBrandsLoading: false,
      isModelsLoading: false,
      isYearsLoading: false,
    );
  } catch (e) {
    state = state.copyWith(
      isBrandsLoading: false,
      isModelsLoading: false,
      isYearsLoading: false,
      errorMessage: e.toString(),
    );
  }
}
}