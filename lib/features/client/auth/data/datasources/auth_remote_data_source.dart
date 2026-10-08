import 'package:qitai/features/client/auth/data/models/auth_session_model.dart';
import 'package:qitai/features/client/user/account/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<void> sendOtp(String phone);

  Future<AuthSessionModel> verifyOtp({
    required String phone,
    required String code,
  });

  Future<UserModel> getCurrentUser();

  Future<void> logout();
}