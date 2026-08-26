import 'package:qitai/features/client/vehicles/data/datasources/vehicle_remote_data_source.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_brand.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_model.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_year.dart';
import 'package:qitai/features/client/vehicles/domain/repositories/vehicles_repository.dart';

class VehicleRepositoryImpl implements VehiclesRepository {
  final VehicleRemoteDataSource dataSource;

  VehicleRepositoryImpl(this.dataSource);

  @override
  Future<List<CarBrand>> getCarBrands() async {
    final models = await dataSource.getCarBrands();

    return models.map((model) => model.toEntity()).toList();
  }
  @override
  Future<List<CarModel>> getCarModels({required int brandId}) async {
    final models = await dataSource.getCarModels(brandId);

    return models.map((model) => model.toEntity()).toList();
  }
  @override
  Future<List<CarYear>> getCarYears({required int modelId}) async {
    final models = await dataSource.getCarYears(modelId);

    return models.map((model) => model.toEntity()).toList();
  }
}