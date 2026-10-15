import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qitai/core/config/app_config.dart';
import 'package:qitai/core/network/auth_interceptor.dart';
import 'package:qitai/core/network/auth_session_events.dart';
import 'package:qitai/core/storage/token_storage_provider.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.apiBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  final tokenStorage = ref.watch(tokenStorageProvider);
  final authSessionEvents = ref.watch(authSessionEventsProvider);

  dio.interceptors.add(
    AuthInterceptor(
      tokenStorage,
      onUnauthorized: authSessionEvents.notifySessionExpired,
    ),
  );

  ref.onDispose(() => dio.close(force: true));

  return dio;
});
