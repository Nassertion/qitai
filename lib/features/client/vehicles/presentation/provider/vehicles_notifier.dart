import 'package:qitai/core/network/dio_provider.dart';
import 'package:qitai/features/client/vehicles/data/model/vehicles_model1.dart';
import 'package:qitai/features/client/vehicles/data/repositories/vehicles_repository1.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicles_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vehicles_notifier.g.dart';

@riverpod
VehicleRepository1 vehicleRepository(Ref ref) {
  final dio = ref.read(dioProvider);
  return VehicleRepository1(dio);
}

@riverpod
class VehicleNotifier extends _$VehicleNotifier {
  late final VehicleRepository1 repo;
  @override
  VehicleState build() {
    repo = ref.read(vehicleRepositoryProvider);
    return const VehicleState();
  }

  Future<void> loadBrands() async {
    state = state.copyWith(isBrandsLoading: true, clearErrorMessage: true);

    try {
      final brands = await repo.fetchCarBrands();

      state = state.copyWith(carBrands: brands, isBrandsLoading: false);
    } catch (e) {
      state = state.copyWith(
        isBrandsLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> selectBrand(CarBrand1 carBrand) async {
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
      final fetchedModels = await repo.fetchCarModels(carBrand.id);

      state = state.copyWith(models: fetchedModels, isModelsLoading: false);
    } catch (e) {
      state = state.copyWith(
        isModelsLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> selectModel(CarModel1 model) async {
    state = state.copyWith(
      selectedModel: model,
      clearSelectedCarYear: true,
      carYears: [],
      isYearsLoading: true,
      clearErrorMessage: true,
    );

    try {
      final fetchedYears = await repo.fetchCarYears(model.id);

      state = state.copyWith(carYears: fetchedYears, isYearsLoading: false);
    } catch (e) {
      state = state.copyWith(isYearsLoading: false, errorMessage: e.toString());
    }
  }

  void selectCarYear(CarYear1 carYear) {
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
