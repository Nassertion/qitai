import 'dart:developer' as developer;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'token_storage.dart';

class SecureTokenStorage implements TokenStorage {
  final FlutterSecureStorage storage;

  SecureTokenStorage(this.storage);

  static const String _accessTokenKey = 'access_token';

  @override
  Future<void> saveAccessToken(String token) async {
    await storage.write(key: _accessTokenKey, value: token);
  }

  @override
  Future<String?> getAccessToken() async {
    final token = await storage.read(key: _accessTokenKey);
    developer.log('🔑 Token Saved/Refreshed: $token', name: 'AUTH_TOKEN');

    return token;
  }

  @override
  Future<void> deleteAccessToken() async {
    await storage.delete(key: _accessTokenKey);
    print('🗑️ Token Deleted');
  }
}
