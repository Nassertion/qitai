
import 'package:qitai/core/errors/app_exception.dart';
import 'package:qitai/core/network/auth_session_events.dart';
import 'package:qitai/features/client/user/account/presentation/providers/current_user_notifier.dart';
import 'package:qitai/features/client/user/cars/presentation/providers/user_car_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth_provider.dart';
import 'auth_state.dart';

part 'auth_notifier.g.dart';

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  int _sessionVersion = 0;

  @override
  AuthState build() {
    final sessionEvents = ref.read(authSessionEventsProvider);

    sessionEvents.registerSessionExpiredHandler(
      _handleUnauthorized,
    );

    ref.onDispose(
      sessionEvents.unregisterSessionExpiredHandler,
    );

    return const AuthInitial();
  }

  int _newSessionOperation() {
    return ++_sessionVersion;
  }

  bool _isCurrentSessionOperation(int version) {
    return ref.mounted && version == _sessionVersion;
  }

  void _clearUserCarsCache() {
    ref.invalidate(userCarsProvider);
  }

  Future<void> initialize() async {
    final version = _newSessionOperation();
    final repository = ref.read(authRepositoryProvider);

    final isAuthenticated = await repository.isAuthenticated();

    if (!_isCurrentSessionOperation(version)) return;

    if (!isAuthenticated) {
      ref.read(currentUserProvider.notifier).clearUser();
      _clearUserCarsCache();
      state = const Unauthenticated();
      return;
    }

    try {
      final user = await ref.read(getCurrentUserProvider)();

      if (!_isCurrentSessionOperation(version)) return;

      ref.read(currentUserProvider.notifier).setUser(user);
      _clearUserCarsCache();

      state = const Authenticated();
    } on AppException catch (e) {
      if (!_isCurrentSessionOperation(version)) return;

      if (e.statusCode == 401) {
        await repository.clearSession();

        if (!_isCurrentSessionOperation(version)) return;

        ref.read(currentUserProvider.notifier).clearUser();
        _clearUserCarsCache();

        state = const Unauthenticated();
        return;
      }

      _clearUserCarsCache();
      state = const Authenticated();
    } catch (_) {
      if (!_isCurrentSessionOperation(version)) return;

      _clearUserCarsCache();
      state = const Authenticated();
    }
  }

  Future<void> _handleUnauthorized() async {
    final version = _newSessionOperation();

    try {
      await ref.read(authRepositoryProvider).clearSession();
    } finally {
      if (_isCurrentSessionOperation(version)) {
        ref.read(currentUserProvider.notifier).clearUser();
        _clearUserCarsCache();

        state = const Unauthenticated();
      }
    }
  }

  Future<void> sendOtp(String phone) {
    final sendOtp = ref.read(sendOtpProvider);

    return sendOtp(phone);
  }

  Future<void> verifyOtp({
    required String phone,
    required String code,
  }) async {
    final version = _newSessionOperation();
    final verifyOtp = ref.read(verifyOtpProvider);

    final session = await verifyOtp(
      phone: phone,
      code: code,
    );

    if (!_isCurrentSessionOperation(version)) return;

    ref.read(currentUserProvider.notifier).setUser(session.user);

    _clearUserCarsCache();

    state = const Authenticated();
  }

  Future<void> logout() async {
    final version = _newSessionOperation();

    try {
      final logout = ref.read(logoutProvider);

      await logout();
    } finally {
      if (_isCurrentSessionOperation(version)) {
        ref.read(currentUserProvider.notifier).clearUser();

        _clearUserCarsCache();

        state = const Unauthenticated();
      }
    }
  }
}
