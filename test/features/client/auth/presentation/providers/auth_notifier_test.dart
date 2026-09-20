import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qitai/features/client/auth/domain/entities/auth_session.dart';
import 'package:qitai/features/client/auth/domain/repositories/auth_repository.dart';
import 'package:qitai/features/client/auth/presentation/providers/auth_notifier.dart';
import 'package:qitai/features/client/auth/presentation/providers/auth_provider.dart';
import 'package:qitai/features/client/auth/presentation/providers/auth_state.dart';
import 'package:qitai/features/client/user/domain/entities/user.dart';
import 'package:qitai/features/client/user/presentation/providers/current_user_notifier.dart';

class FakeAuthRepository implements AuthRepository {
  final AuthSession session;
  bool logoutCalled = false;

  FakeAuthRepository({
    required this.session,
  });

  @override
  Future<void> sendOtp(String phone) async {}

  @override
  Future<AuthSession> verifyOtp({
    required String phone,
    required String code,
  }) async {
    return session;
  }

  @override
  Future<void> logout() async {
    logoutCalled = true;
  }

  @override
  Future<bool> isAuthenticated() async {
    return true;
  }
}

void main() {
  final user = User(
    id: 2,
    phone: '0552222222',
    role: 'user',
    isActive: true,
    name: 'User 8MGJ',
    email: null,
  );

  final session = AuthSession(
    accessToken: 'test_token',
    user: user,
  );

  test(
    'verifyOtp should set current user and authenticate',
    () async {
      final repository = FakeAuthRepository(
        session: session,
      );

      final container = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWithValue(repository),
        ],
      );

      addTearDown(container.dispose);

      final notifier = container.read(authProvider.notifier);

      await notifier.verifyOtp(
        phone: '0552222222',
        code: '532275',
      );

      expect(notifier.state, isA<Authenticated>());

      final currentUser = container.read(currentUserProvider);

      expect(currentUser, isNotNull);
      expect(currentUser?.id, 2);
      expect(currentUser?.phone, '0552222222');
      expect(currentUser?.name, 'User 8MGJ');
    },
  );

  test(
    'logout should clear current user and unauthenticate',
    () async {
      final repository = FakeAuthRepository(
        session: session,
      );

      final container = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWithValue(repository),
        ],
      );

      addTearDown(container.dispose);

      final notifier = container.read(authProvider.notifier);

      container.read(currentUserProvider.notifier).setUser(user);
      notifier.state = const Authenticated();

      await notifier.logout();

      expect(repository.logoutCalled, isTrue);
      expect(notifier.state, isA<Unauthenticated>());
      expect(container.read(currentUserProvider), isNull);
    },
  );
}