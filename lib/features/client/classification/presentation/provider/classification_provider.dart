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

  bool isLoading = false;

  Future<void> loadCarBrands() async {
    isLoading = true;
    notifyListeners();

    try {
      carBrands = await repo.fetchCarBrands();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> selectCarBrand(CarBrand carBrand) async {
    selectedCarBrand = carBrand;
    selectedModel = null;
    selectedCarYear = null;
    models = [];
    carYears = [];

    notifyListeners();

    models = await repo.fetchCarModels(carBrand.id);
    notifyListeners();
  }

  Future<void> selectModel(CarModel model) async {
    selectedModel = model;
    selectedCarYear = null;
    carYears = [];

    notifyListeners();

    carYears = await repo.fetchCarYears(model.id);
    notifyListeners();
  }

  void selectCarYear(CarYear carYear) {
    selectedCarYear = carYear;
    notifyListeners();
  }
}