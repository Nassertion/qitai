import 'package:qitai/features/client/auth/data/models/auth_session_model.dart';

abstract interface class AuthRemoteDataSource {
  // AuthRemoteDataSource(Dio dio);

  Future<void> sendOtp(String phone);

  Future<AuthSessionModel> verifyOtp({
    required String phone,
    required String code,
  });

  Future<void> logout();
}