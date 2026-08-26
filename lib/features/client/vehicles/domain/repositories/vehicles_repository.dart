import 'package:qitai/features/client/vehicles/domain/entities/car_brand.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_model.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_year.dart';

abstract interface class VehiclesRepository {
  Future<List<CarBrand>> getCarBrands();
  Future<List<CarModel>> getCarModels({required int brandId});
  Future<List<CarYear>> getCarYears({required int modelId});
}
