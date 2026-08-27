import 'package:qitai/features/client/vehicles/domain/entities/car_brand.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_model.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_year.dart';
import 'package:qitai/features/client/vehicles/domain/usecases/get_car_brand_use_case.dart';
import 'package:qitai/features/client/vehicles/domain/usecases/get_car_model_use_case.dart';
import 'package:qitai/features/client/vehicles/domain/usecases/get_car_year_use_case.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_provider.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicles_state.dart';
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
}