import 'package:qitai/features/client/user/domain/entities/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_user_notifier.g.dart';

@Riverpod(keepAlive: true)
class CurrentUser extends _$CurrentUser {
  @override
  User? build() {
    return null;
  }

  void setUser(User user) {
    state = user;
  }

  void clearUser() {
    state = null;
  }
}