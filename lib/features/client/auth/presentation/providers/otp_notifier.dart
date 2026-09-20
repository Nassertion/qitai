import 'package:qitai/features/client/auth/presentation/providers/auth_notifier.dart';
import 'package:qitai/features/client/auth/presentation/providers/auth_provider.dart';
import 'package:qitai/features/client/auth/presentation/providers/auth_state.dart';
import 'package:qitai/features/client/user/presentation/providers/current_user_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'otp_notifier.g.dart';

@riverpod
class Otp extends _$Otp {
  @override
  FutureOr<void> build() {}

  Future<void> sendOtp(String phone) async {
    state = const AsyncLoading();

    try {
      await ref.read(sendOtpProvider)(phone);

      state = const AsyncData(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  Future<void> verifyOtp({
    required String phone,
    required String code,
  }) async {
    state = const AsyncLoading();

    try {
      final session = await ref.read(verifyOtpProvider)(
        phone: phone,
        code: code,
      );

      ref
          .read(currentUserProvider.notifier)
          .setUser(session.user);

      ref.read(authProvider.notifier).state =
          const Authenticated();

      state = const AsyncData(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }
}