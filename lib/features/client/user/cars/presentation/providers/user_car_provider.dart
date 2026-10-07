import 'package:qitai/core/network/dio_provider.dart';
import 'package:qitai/features/client/user/cars/data/datasources/user_car_remote_data_source.dart';
import 'package:qitai/features/client/user/cars/data/repositories/user_car_repository_impl.dart';
import 'package:qitai/features/client/user/cars/domain/repositories/user_car_repository.dart';
import 'package:qitai/features/client/user/cars/domain/usecases/add_user_car.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_car_provider.g.dart';

@riverpod
UserCarRemoteDataSource userCarRemoteDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);

  return UserCarRemoteDataSource(dio);
}

@riverpod
UserCarRepository userCarRepository(Ref ref) {
  final dataSource = ref.watch(userCarRemoteDataSourceProvider);

  return UserCarRepositoryImpl(dataSource);
}

@riverpod
AddUserCar addUserCar(Ref ref) {
  final repository = ref.watch(userCarRepositoryProvider);

  return AddUserCar(repository);
}