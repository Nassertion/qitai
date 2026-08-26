import 'package:qitai/core/network/dio_provider.dart';
import 'package:qitai/features/client/vehicles/data/datasources/vehicle_remote_data_source.dart';
import 'package:qitai/features/client/vehicles/data/repositories/vehicle_repository_impl.dart';
import 'package:qitai/features/client/vehicles/domain/repositories/vehicles_repository.dart';
import 'package:qitai/features/client/vehicles/domain/usecases/get_car_brand_use_case.dart';
import 'package:qitai/features/client/vehicles/domain/usecases/get_car_model_use_case.dart';
import 'package:qitai/features/client/vehicles/domain/usecases/get_car_year_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vehicle_provider.g.dart';

@riverpod
VehicleRemoteDataSource vehicleRemoteDataSource(Ref ref){
  final dio = ref.watch(dioProvider);
  return VehicleRemoteDataSource(dio);
}
@riverpod
VehiclesRepository vehiclesRepository(Ref ref){
  final datasource = ref.watch(vehicleRemoteDataSourceProvider);
  return VehicleRepositoryImpl(datasource);
}

@riverpod
GetCarBrands getCarBrands(Ref ref){
  final repo = ref.watch(vehiclesRepositoryProvider);
  return GetCarBrands(repo);
}
@riverpod
GetCarModels getCarModels(Ref ref){
  final repo = ref.watch(vehiclesRepositoryProvider);
  return GetCarModels(repo);
}
@riverpod
GetCarYears getCarYears(Ref ref){
  final repo = ref.watch(vehiclesRepositoryProvider);
  return GetCarYears(repo);
}