import 'package:qitai/core/network/dio_provider.dart';
import 'package:qitai/features/client/auth/data/datasources/auth_remote_data_source.dart';
import 'package:qitai/features/client/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:qitai/features/client/auth/data/repositories/auth_repository_impl.dart';
import 'package:qitai/features/client/auth/domain/repositories/auth_repository.dart';
import 'package:qitai/features/client/auth/domain/usecases/logout.dart';
import 'package:qitai/features/client/auth/domain/usecases/send_otp.dart';
import 'package:qitai/features/client/auth/domain/usecases/verify_otp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:qitai/core/storage/token_storage_provider.dart';

part 'auth_provider.g.dart';

@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);

  return AuthRemoteDataSourceImpl(dio);
}

@riverpod
AuthRepository authRepository(Ref ref) {
  final dataSource = ref.watch(authRemoteDataSourceProvider);
  final tokenStorage = ref.watch(tokenStorageProvider);

  return AuthRepositoryImpl(
    dataSource,
    tokenStorage,
  );
}

@riverpod
SendOtp sendOtp(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);

  return SendOtp(repository);
}

@riverpod
VerifyOtp verifyOtp(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);

  return VerifyOtp(repository);
}

@riverpod
Logout logout(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);

  return Logout(repository);
}