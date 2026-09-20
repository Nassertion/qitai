import 'package:qitai/features/client/user/presentation/providers/current_user_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth_provider.dart';
import 'auth_state.dart';

part 'auth_notifier.g.dart';

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  AuthState build() {
    return const AuthInitial();
  }

  Future<void> initialize() async {
    final repository = ref.read(authRepositoryProvider);

    final isAuthenticated = await repository.isAuthenticated();

    state = isAuthenticated
        ? const Authenticated()
        : const Unauthenticated();
  }

  Future<void> sendOtp(String phone) {
    final sendOtp = ref.read(sendOtpProvider);

    return sendOtp(phone);
  }

  Future<void> verifyOtp({
    required String phone,
    required String code,
  }) async {
    final verifyOtp = ref.read(verifyOtpProvider);

    final session = await verifyOtp(
      phone: phone,
      code: code,
    );

    ref.read(currentUserProvider.notifier).setUser(session.user);

    state = const Authenticated();
  }

  Future<void> logout() async {
    try {
      final logout = ref.read(logoutProvider);

      await logout();
    } finally {
      ref.read(currentUserProvider.notifier).clearUser();

      state = const Unauthenticated();
    }
  }
}