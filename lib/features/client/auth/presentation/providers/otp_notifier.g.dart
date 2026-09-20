// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Otp)
final otpProvider = OtpProvider._();

final class OtpProvider extends $AsyncNotifierProvider<Otp, void> {
  OtpProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'otpProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$otpHash();

  @$internal
  @override
  Otp create() => Otp();
}

String _$otpHash() => r'f82911436a1013142b05f1ef349946fd20dab02f';

abstract class _$Otp extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
