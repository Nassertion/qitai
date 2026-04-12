import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qitai/features/client/vehicles/data/model/vehicles_model.dart';
import 'package:qitai/features/client/vehicles/data/repository/vehicles_repository.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicles.provider.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicles_state.dart';

class ClassificationNotifier extends Notifier<ClassificationState> {
  late final ClassificationRepository repo;

  @override
  ClassificationState build() {
    repo = ref.read(classificationRepositoryProvider);
    return const ClassificationState();
  }

  Future<void> loadBrands() async {
    state = state.copyWith(
      isBrandsLoading: true,
      clearErrorMessage: true,
    );

    try {
      final brands = await repo.fetchCarBrands();

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
      final fetchedModels = await repo.fetchCarModels(carBrand.id);

      state = state.copyWith(
        models: fetchedModels,
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
      final fetchedYears = await repo.fetchCarYears(model.id);

      state = state.copyWith(
        carYears: fetchedYears,
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
    state = state.copyWith(
      clearSelectedCarYear: true,
    );
  }
}