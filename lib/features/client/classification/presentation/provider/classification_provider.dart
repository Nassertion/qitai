import 'package:flutter/material.dart';
import 'package:qitai/features/client/classification/data/model/classification_model.dart';
import 'package:qitai/features/client/classification/data/repository/classification_repository.dart';
class ClassificationProvider extends ChangeNotifier {
  final ClassificationRepository repo;

  ClassificationProvider(this.repo);

  List<CarBrand> carBrands = [];
  List<CarModel> models = [];
  List<CarYear> carYears = [];

  CarBrand? selectedCarBrand;
  CarModel? selectedModel;
  CarYear? selectedCarYear;

  bool isBrandsLoading = false;
  bool isModelsLoading = false;
  bool isYearsLoading = false;

  Future<void> loadCarBrands() async {
    isBrandsLoading = true;
    notifyListeners();

    try {
      carBrands = await repo.fetchCarBrands();
    } finally {
      isBrandsLoading = false;
      notifyListeners();
    }
  }

  Future<void> selectCarBrand(CarBrand carBrand) async {
    selectedCarBrand = carBrand;
    selectedModel = null;
    selectedCarYear = null;
    models = [];
    carYears = [];
    isModelsLoading = true;
    notifyListeners();

    try {
      models = await repo.fetchCarModels(carBrand.id);
    } finally {
      isModelsLoading = false;
      notifyListeners();
    }
  }

  Future<void> selectModel(CarModel model) async {
    selectedModel = model;
    selectedCarYear = null;
    carYears = [];
    isYearsLoading = true;
    notifyListeners();

    try {
      carYears = await repo.fetchCarYears(model.id);
    } finally {
      isYearsLoading = false;
      notifyListeners();
    }
  }

  void selectCarYear(CarYear carYear) {
    selectedCarYear = carYear;
    notifyListeners();
  }
}