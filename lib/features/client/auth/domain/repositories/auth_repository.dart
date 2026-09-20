import 'package:qitai/features/client/auth/domain/entities/auth_session.dart';

abstract interface class AuthRepository {
  Future<void> sendOtp(String phone);

  Future<AuthSession> verifyOtp({
    required String phone,
    required String code,
  });
    Future<void> logout();

}