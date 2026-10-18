import 'package:qitai/features/client/vehicles/domain/entities/car_brand.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_model.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_year.dart';
import 'package:qitai/features/client/vehicles/domain/usecases/get_car_brand.dart';
import 'package:qitai/features/client/vehicles/domain/usecases/get_car_models.dart';
import 'package:qitai/features/client/vehicles/domain/usecases/get_car_years.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_provider.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vehicle_notifier.g.dart';

enum VehicleScope { browse, addCar }

@riverpod
class VehicleNotifier extends _$VehicleNotifier {
  GetCarBrands get getCarBrands => ref.read(getCarBrandsProvider);

  GetCarModels get getCarModels => ref.read(getCarModelsProvider);

  GetCarYears get getCarYears => ref.read(getCarYearsProvider);

  int _brandsRequestId = 0;
  int _modelsRequestId = 0;
  int _yearsRequestId = 0;
  int _vehicleByIdsRequestId = 0;

  bool _disposed = false;

  @override
  VehicleState build(VehicleScope scope) {
    _disposed = false;

    ref.onDispose(() {
      _disposed = true;
      _brandsRequestId++;
      _modelsRequestId++;
      _yearsRequestId++;
      _vehicleByIdsRequestId++;
    });

    return const VehicleState();
  }

  Future<void> loadBrands() async {
    final requestId = ++_brandsRequestId;

    state = state.copyWith(isBrandsLoading: true, clearErrorMessage: true);

    bool isCurrent() => !_disposed && requestId == _brandsRequestId;

    try {
      final brands = await getCarBrands();

      if (!isCurrent()) return;

      state = state.copyWith(carBrands: brands, isBrandsLoading: false);
    } catch (e) {
      if (!isCurrent()) return;

      state = state.copyWith(
        isBrandsLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> selectBrand(CarBrand carBrand) async {
    _vehicleByIdsRequestId++;
    final requestId = ++_modelsRequestId;
    _yearsRequestId++;

    state = state.copyWith(
      selectedCarBrand: carBrand,
      clearSelectedModel: true,
      clearSelectedCarYear: true,
      models: [],
      carYears: [],
      isBrandsLoading: false,
      isModelsLoading: true,
      isYearsLoading: false,
      clearErrorMessage: true,
    );

    bool isCurrent() =>
        !_disposed &&
        requestId == _modelsRequestId &&
        state.selectedCarBrand?.id == carBrand.id;

    try {
      final models = await getCarModels(carBrand.id);

      if (!isCurrent()) return;

      state = state.copyWith(models: models, isModelsLoading: false);
    } catch (e) {
      if (!isCurrent()) return;

      state = state.copyWith(
        isModelsLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> selectModel(CarModel model) async {
    _vehicleByIdsRequestId++;
    final requestId = ++_yearsRequestId;

    state = state.copyWith(
      selectedModel: model,
      clearSelectedCarYear: true,
      carYears: [],
      isBrandsLoading: false,
      isModelsLoading: false,
      isYearsLoading: true,
      clearErrorMessage: true,
    );

    bool isCurrent() =>
        !_disposed &&
        requestId == _yearsRequestId &&
        state.selectedModel?.id == model.id;

    try {
      final years = await getCarYears(model.id);

      if (!isCurrent()) return;

      state = state.copyWith(carYears: years, isYearsLoading: false);
    } catch (e) {
      if (!isCurrent()) return;

      state = state.copyWith(isYearsLoading: false, errorMessage: e.toString());
    }
  }

  void selectCarYear(CarYear carYear) {
    _vehicleByIdsRequestId++;
    _yearsRequestId++;

    state = state.copyWith(
      selectedCarYear: carYear,
      isBrandsLoading: false,
      isModelsLoading: false,
      isYearsLoading: false,
      clearErrorMessage: true,
    );
  }

  void clearBrand() {
    _brandsRequestId++;
    _vehicleByIdsRequestId++;
    _modelsRequestId++;
    _yearsRequestId++;

    state = state.copyWith(
      clearSelectedCarBrand: true,
      clearSelectedModel: true,
      clearSelectedCarYear: true,
      models: [],
      carYears: [],
      isBrandsLoading: false,
      isModelsLoading: false,
      isYearsLoading: false,
      clearErrorMessage: true,
    );
  }

  void clearModel() {
    _vehicleByIdsRequestId++;
    _modelsRequestId++;
    _yearsRequestId++;

    state = state.copyWith(
      clearSelectedModel: true,
      clearSelectedCarYear: true,
      carYears: [],
      isBrandsLoading: false,
      isModelsLoading: false,
      isYearsLoading: false,
      clearErrorMessage: true,
    );
  }

  void clearYear() {
    _vehicleByIdsRequestId++;
    _yearsRequestId++;

    state = state.copyWith(
      clearSelectedCarYear: true,
      isBrandsLoading: false,
      isModelsLoading: false,
      isYearsLoading: false,
      clearErrorMessage: true,
    );
  }

  void clearAll() {
    _brandsRequestId++;
    _vehicleByIdsRequestId++;
    _modelsRequestId++;
    _yearsRequestId++;

    state = state.copyWith(
      clearSelectedCarBrand: true,
      clearSelectedModel: true,
      clearSelectedCarYear: true,
      models: [],
      carYears: [],
      isBrandsLoading: false,
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
    final requestId = ++_vehicleByIdsRequestId;

    _brandsRequestId++;
    _modelsRequestId++;
    _yearsRequestId++;

    state = state.copyWith(
      isBrandsLoading: true,
      isModelsLoading: true,
      isYearsLoading: true,
      clearErrorMessage: true,
    );

    bool isCurrent() => !_disposed && requestId == _vehicleByIdsRequestId;

    try {
      final brands = await getCarBrands();
      if (!isCurrent()) return;

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
      if (!isCurrent()) return;

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
      if (!isCurrent()) return;

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
      if (!isCurrent()) return;

      state = state.copyWith(
        isBrandsLoading: false,
        isModelsLoading: false,
        isYearsLoading: false,
        errorMessage: e.toString(),
      );
    }
  }
}
