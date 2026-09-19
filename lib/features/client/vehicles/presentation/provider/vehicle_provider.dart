import 'package:qitai/core/network/dio_provider.dart';
import 'package:qitai/features/client/vehicles/data/datasources/vehicle_remote_data_source.dart';
import 'package:qitai/features/client/vehicles/data/repositories/vehicle_repository_impl.dart';
import 'package:qitai/features/client/vehicles/domain/repositories/vehicle_repository.dart';
import 'package:qitai/features/client/vehicles/domain/usecases/get_car_brand.dart';
import 'package:qitai/features/client/vehicles/domain/usecases/get_car_models.dart';
import 'package:qitai/features/client/vehicles/domain/usecases/get_car_years.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vehicle_provider.g.dart';

@riverpod
VehicleRemoteDataSource vehicleRemoteDataSource(Ref ref){
  final dio = ref.watch(dioProvider);
  return VehicleRemoteDataSource(dio);
}
@riverpod
VehicleRepository vehicleRepository(Ref ref){
  final datasource = ref.watch(vehicleRemoteDataSourceProvider);
  return VehicleRepositoryImpl(datasource);
}

@riverpod
GetCarBrands getCarBrands(Ref ref){
  final repo = ref.watch(vehicleRepositoryProvider);
  return GetCarBrands(repo);
}
@riverpod
GetCarModels getCarModels(Ref ref){
  final repo = ref.watch(vehicleRepositoryProvider);
  return GetCarModels(repo);
}
@riverpod
GetCarYears getCarYears(Ref ref){
  final repo = ref.watch(vehicleRepositoryProvider);
  return GetCarYears(repo);
}