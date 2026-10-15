import 'dart:async';

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

class MockErrorInterceptorHandler extends Mock
    implements ErrorInterceptorHandler {}

void main() {
  group('AuthInterceptor', () {
    test(
      'should invoke unauthorized callback when a protected request returns 401',
      () async {
        final callbackCompleted = Completer<void>();
        var callbackCalled = false;

        final interceptor = AuthInterceptor(
          FakeTokenStorage(accessToken: 'expired_token'),
          onUnauthorized: () async {
            callbackCalled = true;

            if (!callbackCompleted.isCompleted) {
              callbackCompleted.complete();
            }
          },
        );

        final handler = MockErrorInterceptorHandler();
        final requestOptions = RequestOptions(
          path: '/products/1',
        );

        final error = DioException(
          requestOptions: requestOptions,
          response: Response<dynamic>(
            requestOptions: requestOptions,
            statusCode: 401,
          ),
          type: DioExceptionType.badResponse,
        );

        interceptor.onError(error, handler);

        await callbackCompleted.future.timeout(
          const Duration(seconds: 2),
        );

        // ننتظر اكتمال معالجة الخطأ داخل الـ interceptor.
        await Future<void>.delayed(Duration.zero);

        expect(callbackCalled, isTrue);
        verify(() => handler.next(error)).called(1);
      },
    );

    test(
      'should not invoke unauthorized callback for public OTP requests',
      () async {
        var callbackCalled = false;

        final interceptor = AuthInterceptor(
          FakeTokenStorage(accessToken: 'expired_token'),
          onUnauthorized: () async {
            callbackCalled = true;
          },
        );

        final handler = MockErrorInterceptorHandler();
        final requestOptions = RequestOptions(
          path: '/auth/verify-otp',
        );

        final error = DioException(
          requestOptions: requestOptions,
          response: Response<dynamic>(
            requestOptions: requestOptions,
            statusCode: 401,
          ),
          type: DioExceptionType.badResponse,
        );

        interceptor.onError(error, handler);

        await Future<void>.delayed(Duration.zero);

        expect(callbackCalled, isFalse);
        verify(() => handler.next(error)).called(1);
      },
    );

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