import 'package:qitai/features/client/user/domain/entities/user.dart';

class AuthSession {
  final String accessToken;
  final User user;

  const AuthSession({
    required this.accessToken,
    required this.user,
  });
}