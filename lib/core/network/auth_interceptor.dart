
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:qitai/core/storage/token_storage.dart';

class AuthInterceptor extends Interceptor {
  final TokenStorage tokenStorage;
  final Future<void> Function()? onUnauthorized;

  AuthInterceptor(
    this.tokenStorage, {
    this.onUnauthorized,
  });

  static const _publicPaths = {
    '/auth/send-otp',
    '/auth/verify-otp',
    '/auth/google',
  };

  Future<void>? _handlingUnauthorized;

  bool _isPublicPath(String path) {
    return _publicPaths.contains(path);
  }

  // Check the credentials sent with this specific request.
  bool _hasBearerToken(RequestOptions options) {
    for (final entry in options.headers.entries) {
      if (entry.key.toLowerCase() != 'authorization') {
        continue;
      }

      final value = entry.value;

      if (value is! String) {
        return false;
      }

      return RegExp(
        r'^Bearer\s+\S+$',
        caseSensitive: false,
      ).hasMatch(value.trim());
    }

    return false;
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_isPublicPath(options.path)) {
      handler.next(options);
      return;
    }

    final accessToken = await tokenStorage.getAccessToken();

    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    handler.next(options);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final isUnauthorized = err.response?.statusCode == 401;
    final isPublicRequest = _isPublicPath(err.requestOptions.path);
    final hasBearerToken = _hasBearerToken(err.requestOptions);

    // A guest's 401 must not expire an authenticated session.
    if (!isUnauthorized || isPublicRequest || !hasBearerToken) {
      handler.next(err);
      return;
    }

    // Preserve single-flight handling for concurrent 401 responses.
    final handling =
        _handlingUnauthorized ??= _handleUnauthorized();

    try {
      await handling;
    } finally {
      if (identical(_handlingUnauthorized, handling)) {
        _handlingUnauthorized = null;
      }

      handler.next(err);
    }
  }

  Future<void> _handleUnauthorized() async {
    try {
      await onUnauthorized?.call();
    } catch (error, stackTrace) {
      if (kDebugMode) {
        debugPrint(
          'Failed to handle expired authentication session: $error',
        );
        debugPrintStack(stackTrace: stackTrace);
      }
    }
  }
}
