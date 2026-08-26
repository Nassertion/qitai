import 'package:qitai/features/client/vehicles/domain/entities/car_brand.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_model.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_year.dart';

abstract interface class VehiclesRepository {
  Future<List<CarBrand>> getBrands();
  Future<List<CarModel>> getModels({required int brandId});
  Future<List<CarYear>> getYear({required int modelId});
}
