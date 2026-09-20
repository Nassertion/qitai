import '../repositories/auth_repository.dart';

class SendOtp {
  final AuthRepository repository;

  const SendOtp(this.repository);

  Future<void> call(String phone) {
    return repository.sendOtp(phone);
  }
}