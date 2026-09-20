import 'package:qitai/features/client/auth/domain/entities/auth_session.dart';
import 'package:qitai/features/client/user/data/models/user_model.dart';

class AuthSessionModel {
  final String accessToken;
  final UserModel user;

  AuthSessionModel({
    required this.accessToken,
    required this.user,
  });

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) {
    return AuthSessionModel(
      accessToken: json['token'] as String,
      user: UserModel.fromJson(
        json['user'] as Map<String, dynamic>,
      ),
    );
  }

  AuthSession toEntity() {
    return AuthSession(
      accessToken: accessToken,
      user: user.toEntity(),
    );
  }
}