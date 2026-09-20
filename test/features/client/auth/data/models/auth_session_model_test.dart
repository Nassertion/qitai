import 'package:flutter_test/flutter_test.dart';
import 'package:qitai/features/client/auth/data/models/auth_session_model.dart';

void main() {
  group('AuthSessionModel.fromJson', () {
    test('should parse auth session json correctly', () {
      final json = {
        'token': 'test_token',
        'user': {
          'id': 2,
          'phone': '0552222222',
          'role': 'user',
          'is_active': true,
          'name': 'User 8MGJ',
          'created_at': '2026-09-19T16:34:08.000000Z',
          'updated_at': '2026-09-19T16:34:08.000000Z',
          'email': null,
        },
      };

      final result = AuthSessionModel.fromJson(json);

      expect(result.accessToken, 'test_token');

      expect(result.user.id, 2);
      expect(result.user.phone, '0552222222');
      expect(result.user.role, 'user');
      expect(result.user.isActive, true);
      expect(result.user.name, 'User 8MGJ');
      expect(result.user.email, isNull);
    });
  });
}