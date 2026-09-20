import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:qitai/core/storage/secure_storage_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'token_storage.dart';

part 'token_storage_provider.g.dart';

@riverpod
TokenStorage tokenStorage(Ref ref) {
  final storage = FlutterSecureStorage();

  return SecureTokenStorage(storage);
}