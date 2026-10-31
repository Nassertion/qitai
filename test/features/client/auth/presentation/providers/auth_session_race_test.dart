
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:qitai/features/client/auth/domain/entities/auth_session.dart';
import 'package:qitai/features/client/auth/domain/repositories/auth_repository.dart';
import 'package:qitai/features/client/auth/presentation/providers/auth_notifier.dart';
import 'package:qitai/features/client/auth/presentation/providers/auth_provider.dart';
import 'package:qitai/features/client/auth/presentation/providers/auth_state.dart';
import 'package:qitai/features/client/user/account/domain/entities/user.dart';

// # Fake Auth Repository
class FakeAuthRepository implements AuthRepository {
  final authCheck = Completer<bool>();

  int logoutCalls = 0;
  int getCurrentUserCalls = 0;

  @override
  Future<bool> isAuthenticated() {
    return authCheck.future;
  }

  @override
  Future<void> logout() async {
    logoutCalls++;
  }

  @override
  Future<void> clearSession() async {}

  @override
  Future<User> getCurrentUser() async {
    getCurrentUserCalls++;

    // # Simulate Failure After Stale Session Check
    // AuthNotifier currently treats non-401 failures as authenticated.
    throw Exception('Unable to fetch current user');
  }

  @override
  Future<void> sendOtp(String phone) async {
    throw UnimplementedError();
  }

  @override
  Future<AuthSession> verifyOtp({
    required String phone,
    required String code,
  }) async {
    throw UnimplementedError();
  }
}

void main() {
  // # Initialize vs Logout Race Condition
  test(
    'Old initialize must not authenticate after logout',
    () async {
      // # Arrange
      final repository = FakeAuthRepository();

      final container = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWith(
            (ref) => repository,
          ),
        ],
      );

      addTearDown(container.dispose);

      // # Keep Auth Provider Alive
      final subscription = container.listen(
        authProvider,
        (_, _) {},
      );
      addTearDown(subscription.close);

      final notifier = container.read(
        authProvider.notifier,
      );

      // # Start Initialization
      final initializeFuture = notifier.initialize();

      // The session check is still pending.
      expect(
        container.read(authProvider),
        isA<AuthInitial>(),
      );

      // # Logout Before Initialization Completes
      await notifier.logout();

      expect(repository.logoutCalls, 1);

      expect(
        container.read(authProvider),
        isA<Unauthenticated>(),
      );

      // # Complete Old Session Check
      repository.authCheck.complete(true);

      await initializeFuture;

      // # Assert Logout State Is Preserved
      expect(
        container.read(authProvider),
        isA<Unauthenticated>(),
        reason:
            'A stale initialization response must not '
            'restore authentication after logout.',
      );
    },
  );
}
