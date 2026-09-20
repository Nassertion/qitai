import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

class VerifyOtp {
  final AuthRepository repository;

  const VerifyOtp(this.repository);

  Future<AuthSession> call({
    required String phone,
    required String code,
  }) {
    return repository.verifyOtp(
      phone: phone,
      code: code,
    );
  }
}