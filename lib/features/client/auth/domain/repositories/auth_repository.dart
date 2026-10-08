import 'package:qitai/features/client/auth/domain/entities/auth_session.dart';
import 'package:qitai/features/client/user/account/domain/entities/user.dart';

abstract interface class AuthRepository {
  Future<void> sendOtp(String phone);

  Future<AuthSession> verifyOtp({
    required String phone,
    required String code,
  });

  Future<User> getCurrentUser();

  Future<void> logout();

  Future<void> clearSession();

  Future<bool> isAuthenticated();
}