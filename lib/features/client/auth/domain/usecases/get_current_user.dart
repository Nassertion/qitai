import 'package:qitai/features/client/auth/domain/repositories/auth_repository.dart';
import 'package:qitai/features/client/user/account/domain/entities/user.dart';

class GetCurrentUser {
  final AuthRepository repository;

  const GetCurrentUser(this.repository);

  Future<User> call() {
    return repository.getCurrentUser();
  }
}