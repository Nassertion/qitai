
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
      'invokes unauthorized callback for a 401 request with Bearer token',
      () async {
        final callbackCompleted = Completer<void>();
        var callbackCalled = false;

        final interceptor = AuthInterceptor(
          FakeTokenStorage(accessToken: 'expired_token'),
          onUnauthorized: () async {
            callbackCalled = true;
            callbackCompleted.complete();
          },
        );

        final handler = MockErrorInterceptorHandler();

        final requestOptions = RequestOptions(
          path: '/products/1',
          headers: {
            'Authorization': 'Bearer expired_token',
          },
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

        await Future<void>.delayed(Duration.zero);

        expect(callbackCalled, isTrue);
        verify(() => handler.next(error)).called(1);
      },
    );

    test(
      'does not expire session for guest 401 without Authorization',
      () async {
        var callbackCalled = false;

        final interceptor = AuthInterceptor(
          FakeTokenStorage(),
          onUnauthorized: () async {
            callbackCalled = true;
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

        await Future<void>.delayed(Duration.zero);

        expect(callbackCalled, isFalse);
        verify(() => handler.next(error)).called(1);
      },
    );

    test(
      'uses request headers rather than current token storage for 401',
      () async {
        var callbackCalled = false;

        // Storage may change while a request is in flight.
        final interceptor = AuthInterceptor(
          FakeTokenStorage(accessToken: 'another_token'),
          onUnauthorized: () async {
            callbackCalled = true;
          },
        );

        final handler = MockErrorInterceptorHandler();

        // This request was sent without credentials.
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

        await Future<void>.delayed(Duration.zero);

        expect(callbackCalled, isFalse);
        verify(() => handler.next(error)).called(1);
      },
    );

    test(
      'does not invoke unauthorized callback for public OTP requests',
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
      'does not expire session on HTTP 403',
      () async {
        var callbackCalled = false;

        final interceptor = AuthInterceptor(
          FakeTokenStorage(accessToken: 'test_token'),
          onUnauthorized: () async {
            callbackCalled = true;
          },
        );

        final handler = MockErrorInterceptorHandler();

        final requestOptions = RequestOptions(
          path: '/products/1',
          headers: {
            'Authorization': 'Bearer test_token',
          },
        );

        final error = DioException(
          requestOptions: requestOptions,
          response: Response<dynamic>(
            requestOptions: requestOptions,
            statusCode: 403,
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
