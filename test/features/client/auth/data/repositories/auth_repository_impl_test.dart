import 'package:flutter_test/flutter_test.dart';
import 'package:qitai/features/client/auth/data/datasources/auth_remote_data_source.dart';
import 'package:qitai/features/client/auth/data/models/auth_session_model.dart';
import 'package:qitai/features/client/auth/data/repositories/auth_repository_impl.dart';
import 'package:qitai/core/storage/token_storage.dart';
import 'package:qitai/features/client/user/data/models/user_model.dart';

class FakeAuthRemoteDataSource implements AuthRemoteDataSource {
  AuthSessionModel? session;
  String? receivedPhone;
  String? receivedCode;

  bool sendOtpCalled = false;
  bool verifyOtpCalled = false;
  bool logoutCalled = false;

  Exception? logoutException;

  @override
  Future<void> sendOtp(String phone) async {
    sendOtpCalled = true;
    receivedPhone = phone;
  }

  @override
  Future<AuthSessionModel> verifyOtp({
    required String phone,
    required String code,
  }) async {
    verifyOtpCalled = true;
    receivedPhone = phone;
    receivedCode = code;

    return session!;
  }

  @override
  Future<void> logout() async {
    logoutCalled = true;

    if (logoutException != null) {
      throw logoutException!;
    }
  }
}

class FakeTokenStorage implements TokenStorage {
  String? accessToken;

  bool saveCalled = false;
  bool getCalled = false;
  bool deleteCalled = false;

  @override
  Future<void> saveAccessToken(String token) async {
    saveCalled = true;
    accessToken = token;
  }

  @override
  Future<String?> getAccessToken() async {
    getCalled = true;
    return accessToken;
  }

  @override
  Future<void> deleteAccessToken() async {
    deleteCalled = true;
    accessToken = null;
  }
}

void main() {
  late FakeAuthRemoteDataSource remoteDataSource;
  late FakeTokenStorage tokenStorage;
  late AuthRepositoryImpl repository;

  setUp(() {
    remoteDataSource = FakeAuthRemoteDataSource();
    tokenStorage = FakeTokenStorage();

    repository = AuthRepositoryImpl(
      remoteDataSource,
      tokenStorage,
    );
  });

  group('sendOtp', () {
    test('should call remote data source with the phone number', () async {
      await repository.sendOtp('0552222222');

      expect(remoteDataSource.sendOtpCalled, isTrue);
      expect(remoteDataSource.receivedPhone, '0552222222');
    });
  });

  group('verifyOtp', () {
    test(
      'should return session and save access token',
      () async {
        final session = AuthSessionModel(
          accessToken: 'test_token',
          user: UserModel(
            id: 2,
            phone: '0552222222',
            role: 'user',
            isActive: true,
            name: 'User 8MGJ',
            email: null,
            createdAt: DateTime.parse(
              '2026-09-19T16:34:08.000000Z',
            ),
            updatedAt: DateTime.parse(
              '2026-09-19T16:34:08.000000Z',
            ),
          ),
        );

        remoteDataSource.session = session;

        final result = await repository.verifyOtp(
          phone: '0552222222',
          code: '532275',
        );

        expect(remoteDataSource.verifyOtpCalled, isTrue);
        expect(remoteDataSource.receivedPhone, '0552222222');
        expect(remoteDataSource.receivedCode, '532275');

        expect(tokenStorage.saveCalled, isTrue);
        expect(tokenStorage.accessToken, 'test_token');

        expect(result.accessToken, 'test_token');
        expect(result.user.id, 2);
        expect(result.user.phone, '0552222222');
      },
    );
  });

  group('logout', () {
test(
  'should call remote logout and delete local token',
  () async {
    tokenStorage.accessToken = 'test_token';

    await repository.logout();

    expect(tokenStorage.getCalled, isTrue);
    expect(remoteDataSource.logoutCalled, isTrue);
    expect(tokenStorage.deleteCalled, isTrue);
    expect(tokenStorage.accessToken, isNull);
  },
);

 test(
  'should delete local token even when remote logout fails',
  () async {
    tokenStorage.accessToken = 'test_token';
    remoteDataSource.logoutException = Exception('Network error');

    await expectLater(
      repository.logout(),
      throwsA(isA<Exception>()),
    );

    expect(remoteDataSource.logoutCalled, isTrue);
    expect(tokenStorage.deleteCalled, isTrue);
    expect(tokenStorage.accessToken, isNull);
  },
);

    test(
      'should do nothing when there is no access token',
      () async {
        await repository.logout();

        expect(tokenStorage.getCalled, isTrue);
        expect(remoteDataSource.logoutCalled, isFalse);
        expect(tokenStorage.deleteCalled, isFalse);
      },
    );
  });
  group('isAuthenticated', () {
  test(
    'should return true when access token exists',
    () async {
      tokenStorage.accessToken = 'test_token';

      final result = await repository.isAuthenticated();

      expect(result, isTrue);
      expect(tokenStorage.getCalled, isTrue);
    },
  );

  test(
    'should return false when access token does not exist',
    () async {
      final result = await repository.isAuthenticated();

      expect(result, isFalse);
      expect(tokenStorage.getCalled, isTrue);
    },
  );
});
}