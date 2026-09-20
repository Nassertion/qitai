import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'token_storage.dart';

class SecureTokenStorage implements TokenStorage {
  final FlutterSecureStorage storage;

  SecureTokenStorage(this.storage);

  static const String _accessTokenKey = 'access_token';

  @override
  Future<void> saveAccessToken(String token) {
    return storage.write(
      key: _accessTokenKey,
      value: token,
    );
  }

  @override
  Future<String?> getAccessToken() {
    return storage.read(
      key: _accessTokenKey,
    );
  }

  @override
  Future<void> deleteAccessToken() {
    return storage.delete(
      key: _accessTokenKey,
    );
  }
}