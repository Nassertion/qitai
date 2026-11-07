
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:qitai/core/errors/app_exception.dart';
import 'package:qitai/features/client/auth/domain/entities/auth_session.dart';
import 'package:qitai/features/client/auth/domain/repositories/auth_repository.dart';
import 'package:qitai/features/client/auth/presentation/providers/auth_provider.dart';
import 'package:qitai/features/client/auth/presentation/widgets/otp_auth_content.dart';
import 'package:qitai/features/client/user/account/domain/entities/user.dart';

class TestOtpRepository implements AuthRepository {
  TestOtpRepository(this.error);

  final AppException error;

  String? submittedCode;

  @override
  Future<AuthSession> verifyOtp({
    required String phone,
    required String code,
  }) async {
    submittedCode = code;
    throw error;
  }

  @override
  Future<void> sendOtp(String phone) async {}

  @override
  Future<User> getCurrentUser() async {
    throw UnimplementedError();
  }

  @override
  Future<bool> isAuthenticated() async => false;

  @override
  Future<void> clearSession() async {}

  @override
  Future<void> logout() async {}
}

void main() {
  Future<void> buildOtpScreen(
    WidgetTester tester,
    TestOtpRepository repository,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(repository),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: OtpAuthContent(
              phone: '0551234567',
            ),
          ),
        ),
      ),
    );

    await tester.pump();
  }

  testWidgets(
    'Pasting a complete OTP fills all six fields',
    (tester) async {
      final repository = TestOtpRepository(
        const AppException(
          'رمز غير صحيح',
          statusCode: 422,
        ),
      );

      await buildOtpScreen(tester, repository);

      final fields = find.byType(TextField);

      expect(fields, findsNWidgets(6));

      // Simulate pasting an entire OTP.
      await tester.enterText(fields.first, '123456');
      await tester.pump();

      final expectedDigits = [
        '1',
        '2',
        '3',
        '4',
        '5',
        '6',
      ];

      for (var index = 0; index < 6; index++) {
        final field = tester.widget<TextField>(
          fields.at(index),
        );

        expect(
          field.controller!.text,
          expectedDigits[index],
        );
      }

      // Verify submits the complete code.
      await tester.tap(find.text('التحقق'));
      await tester.pump();

      expect(repository.submittedCode, '123456');
    },
  );

  testWidgets(
    'Invalid OTP shows inline validation error',
    (tester) async {
      final repository = TestOtpRepository(
        const AppException(
          'رمز غير صحيح',
          statusCode: 422,
        ),
      );

      await buildOtpScreen(tester, repository);

      await tester.enterText(
        find.byType(TextField).first,
        '123456',
      );
      await tester.pump();

      await tester.tap(find.text('التحقق'));
      await tester.pump();
      await tester.pump();

      expect(
        find.text('الرمز المدخل غير صحيح حاول مرة أخرى'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'Network error does not mark the OTP as invalid',
    (tester) async {
      final repository = TestOtpRepository(
        const AppException(
          'تحقق من اتصال الإنترنت',
        ),
      );

      await buildOtpScreen(tester, repository);

      await tester.enterText(
        find.byType(TextField).first,
        '123456',
      );
      await tester.pump();

      await tester.tap(find.text('التحقق'));
      await tester.pump();
      await tester.pump();

      // A network failure must not mean the OTP is wrong.
      expect(
        find.text('الرمز المدخل غير صحيح حاول مرة أخرى'),
        findsNothing,
      );

      expect(
        find.text('تحقق من اتصال الإنترنت'),
        findsOneWidget,
      );

      expect(repository.submittedCode, '123456');
    },
  );
}
