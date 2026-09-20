import 'package:qitai/features/client/auth/domain/entities/auth_session.dart';

abstract interface class AuthRepository {
  Future<void> sendOtp(String phone);

  Future<AuthSession> verifyOtp({
    required String phone,
    required String code,
  });
    Future<void> logout();


    /// يتحقق من وجود access token محفوظ (presence check فقط).
/// لا يتحقق من صلاحية أو انتهاء التوكن — هذا يعتمد حاليًا
/// على أن الـ Backend لا يرسل expiry، والتوكن يُحذف فقط عند logout.
Future<bool> isAuthenticated();

}