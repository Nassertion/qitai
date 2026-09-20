import 'package:qitai/core/storage/token_storage.dart';
import 'package:qitai/features/client/auth/data/datasources/auth_remote_data_source.dart';
import 'package:qitai/features/client/auth/domain/entities/auth_session.dart';
import 'package:qitai/features/client/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final TokenStorage tokenStorage;

  AuthRepositoryImpl(
    this.remoteDataSource,
    this.tokenStorage,
  );

  @override
  Future<void> sendOtp(String phone) {
    return remoteDataSource.sendOtp(phone);
  }

  @override
  Future<AuthSession> verifyOtp({
    required String phone,
    required String code,
  }) async {
    final sessionModel = await remoteDataSource.verifyOtp(
      phone: phone,
      code: code,
    );

    await tokenStorage.saveAccessToken(
      sessionModel.accessToken,
    );

    return sessionModel.toEntity();
  }

  @override
  Future<void> logout() async {
    final accessToken = await tokenStorage.getAccessToken();

    if (accessToken == null) {
      return;
    }

    try {
      await remoteDataSource.logout();
    } finally {
      await tokenStorage.deleteAccessToken();
    }
  }



@override
Future<bool> isAuthenticated() async {
  final accessToken = await tokenStorage.getAccessToken();

  return accessToken != null;
}
}