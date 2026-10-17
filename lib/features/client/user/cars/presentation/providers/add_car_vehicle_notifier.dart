import 'package:qitai/features/client/vehicles/domain/entities/car_brand.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_model.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_year.dart';
import 'package:qitai/features/client/vehicles/domain/usecases/get_car_brand.dart';
import 'package:qitai/features/client/vehicles/domain/usecases/get_car_models.dart';
import 'package:qitai/features/client/vehicles/domain/usecases/get_car_years.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_provider.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_car_vehicle_notifier.g.dart';

@riverpod
class AddCarVehicleNotifier extends _$AddCarVehicleNotifier {
  late final GetCarBrands getCarBrands;
  late final GetCarModels getCarModels;
  late final GetCarYears getCarYears;

  int _brandsRequestId = 0;
  int _modelsRequestId = 0;
  int _yearsRequestId = 0;

  @override
  VehicleState build() {
    getCarBrands = ref.read(getCarBrandsProvider);
    getCarModels = ref.read(getCarModelsProvider);
    getCarYears = ref.read(getCarYearsProvider);

    // Invalidate pending requests when this screen's state is disposed.
    ref.onDispose(() {
      _brandsRequestId++;
      _modelsRequestId++;
      _yearsRequestId++;
    });

    return const VehicleState();
  }

  Future<void> loadBrands() async {
    final requestId = ++_brandsRequestId;

    state = state.copyWith(isBrandsLoading: true, clearErrorMessage: true);

    try {
      final brands = await getCarBrands();

      if (requestId != _brandsRequestId) return;

      state = state.copyWith(carBrands: brands, isBrandsLoading: false);
    } catch (e) {
      if (requestId != _brandsRequestId) return;

      state = state.copyWith(
        isBrandsLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> selectBrand(CarBrand carBrand) async {
    final requestId = ++_modelsRequestId;

    // Changing the brand invalidates any pending model/year requests.
    _yearsRequestId++;

    state = state.copyWith(
      selectedCarBrand: carBrand,
      clearSelectedModel: true,
      clearSelectedCarYear: true,
      models: [],
      carYears: [],
      isModelsLoading: true,
      isYearsLoading: false,
      clearErrorMessage: true,
    );

    try {
      final models = await getCarModels(carBrand.id);

      if (requestId != _modelsRequestId) return;
      if (state.selectedCarBrand?.id != carBrand.id) return;

      state = state.copyWith(models: models, isModelsLoading: false);
    } catch (e) {
      if (requestId != _modelsRequestId) return;
      if (state.selectedCarBrand?.id != carBrand.id) return;

      state = state.copyWith(
        isModelsLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> selectModel(CarModel model) async {
    final requestId = ++_yearsRequestId;

    state = state.copyWith(
      selectedModel: model,
      clearSelectedCarYear: true,
      carYears: [],
      isYearsLoading: true,
      clearErrorMessage: true,
    );

    try {
      final years = await getCarYears(model.id);

      if (requestId != _yearsRequestId) return;
      if (state.selectedModel?.id != model.id) return;

      state = state.copyWith(carYears: years, isYearsLoading: false);
    } catch (e) {
      if (requestId != _yearsRequestId) return;
      if (state.selectedModel?.id != model.id) return;

      state = state.copyWith(isYearsLoading: false, errorMessage: e.toString());
    }
  }

  void selectCarYear(CarYear carYear) {
    state = state.copyWith(selectedCarYear: carYear, clearErrorMessage: true);
  }

  void clearBrand() {
    _modelsRequestId++;
    _yearsRequestId++;

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

  void clearModel() {
    _yearsRequestId++;

    state = state.copyWith(
      clearSelectedModel: true,
      clearSelectedCarYear: true,
      carYears: [],
      isYearsLoading: false,
      clearErrorMessage: true,
    );
  }

  void clearYear() {
    state = state.copyWith(clearSelectedCarYear: true, clearErrorMessage: true);
  }

  void clearAll() {
    _brandsRequestId++;
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
}
