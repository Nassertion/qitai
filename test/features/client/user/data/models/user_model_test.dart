import 'package:flutter_test/flutter_test.dart';
import 'package:qitai/features/client/user/data/models/user_model.dart';

void main() {
  group('UserModel.fromJson', () {
    test('should parse user json correctly', () {
      final json = {
        'id': 2,
        'phone': '0552222222',
        'role': 'user',
        'is_active': true,
        'name': 'User 8MGJ',
        'created_at': '2026-09-19T16:34:08.000000Z',
        'updated_at': '2026-09-19T16:34:08.000000Z',
        'email': null,
      };

      final result = UserModel.fromJson(json);

      expect(result.id, 2);
      expect(result.phone, '0552222222');
      expect(result.role, 'user');
      expect(result.isActive, true);
      expect(result.name, 'User 8MGJ');
      expect(
        result.createdAt,
        DateTime.parse('2026-09-19T16:34:08.000000Z'),
      );
      expect(
        result.updatedAt,
        DateTime.parse('2026-09-19T16:34:08.000000Z'),
      );
      expect(result.email, isNull);
    });

    test('should allow nullable date and email fields', () {
      final json = {
        'id': 2,
        'phone': '0552222222',
        'role': 'user',
        'is_active': true,
        'name': 'User 8MGJ',
        'created_at': null,
        'updated_at': null,
        'email': null,
      };

      final result = UserModel.fromJson(json);

      expect(result.createdAt, isNull);
      expect(result.updatedAt, isNull);
      expect(result.email, isNull);
    });
  });
}