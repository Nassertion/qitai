import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qitai/core/network/auth_interceptor.dart';
import 'package:qitai/core/storage/token_storage.dart';

class FakeTokenStorage implements TokenStorage {
  String? accessToken;

  FakeTokenStorage({this.accessToken});

  @override
  Future<void> saveAccessToken(String token) async {
    accessToken = token;
  }

  @override
  Future<String?> getAccessToken() async {
    return accessToken;
  }

  @override
  Future<void> deleteAccessToken() async {
    accessToken = null;
  }
}

class MockRequestInterceptorHandler extends Mock
    implements RequestInterceptorHandler {}

void main() {
  group('AuthInterceptor', () {
    test(
      'should add authorization header when access token exists',
      () async {
        final tokenStorage = FakeTokenStorage(
          accessToken: 'test_token',
        );

        final interceptor = AuthInterceptor(tokenStorage);
        final handler = MockRequestInterceptorHandler();

        final options = RequestOptions(
          path: '/orders',
        );

        await interceptor.onRequest(options, handler);

        expect(
          options.headers['Authorization'],
          'Bearer test_token',
        );

        verify(() => handler.next(options)).called(1);
      },
    );

    test(
      'should not add authorization header when access token does not exist',
      () async {
        final tokenStorage = FakeTokenStorage();
        final interceptor = AuthInterceptor(tokenStorage);
        final handler = MockRequestInterceptorHandler();

        final options = RequestOptions(
          path: '/orders',
        );

        await interceptor.onRequest(options, handler);

        expect(
          options.headers.containsKey('Authorization'),
          isFalse,
        );

        verify(() => handler.next(options)).called(1);
      },
    );

    test(
      'should not add authorization header to public auth endpoints',
      () async {
        final tokenStorage = FakeTokenStorage(
          accessToken: 'test_token',
        );

        final interceptor = AuthInterceptor(tokenStorage);
        final handler = MockRequestInterceptorHandler();

        final options = RequestOptions(
          path: '/auth/send-otp',
        );

        await interceptor.onRequest(options, handler);

        expect(
          options.headers.containsKey('Authorization'),
          isFalse,
        );

        verify(() => handler.next(options)).called(1);
      },
    );
  });
}