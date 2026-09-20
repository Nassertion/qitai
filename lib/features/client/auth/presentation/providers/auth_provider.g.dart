// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authRemoteDataSource)
final authRemoteDataSourceProvider = AuthRemoteDataSourceProvider._();

final class AuthRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          AuthRemoteDataSource,
          AuthRemoteDataSource,
          AuthRemoteDataSource
        >
    with $Provider<AuthRemoteDataSource> {
  AuthRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<AuthRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuthRemoteDataSource create(Ref ref) {
    return authRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRemoteDataSource>(value),
    );
  }
}

String _$authRemoteDataSourceHash() =>
    r'8f8f836bda987e426868493cc831ede02dc603fa';

@ProviderFor(authRepository)
final authRepositoryProvider = AuthRepositoryProvider._();

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'76eb08c1e8ede1b83f27349abfc4521775a1b831';

@ProviderFor(sendOtp)
final sendOtpProvider = SendOtpProvider._();

final class SendOtpProvider
    extends $FunctionalProvider<SendOtp, SendOtp, SendOtp>
    with $Provider<SendOtp> {
  SendOtpProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sendOtpProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sendOtpHash();

  @$internal
  @override
  $ProviderElement<SendOtp> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SendOtp create(Ref ref) {
    return sendOtp(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SendOtp value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SendOtp>(value),
    );
  }
}

String _$sendOtpHash() => r'f46e8625a111a04f47bdc49ba08d02567449fc3d';

@ProviderFor(verifyOtp)
final verifyOtpProvider = VerifyOtpProvider._();

final class VerifyOtpProvider
    extends $FunctionalProvider<VerifyOtp, VerifyOtp, VerifyOtp>
    with $Provider<VerifyOtp> {
  VerifyOtpProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'verifyOtpProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$verifyOtpHash();

  @$internal
  @override
  $ProviderElement<VerifyOtp> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VerifyOtp create(Ref ref) {
    return verifyOtp(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VerifyOtp value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VerifyOtp>(value),
    );
  }
}

String _$verifyOtpHash() => r'97426b52687b8a554e68a06dfb3431087c57e1b4';

@ProviderFor(logout)
final logoutProvider = LogoutProvider._();

final class LogoutProvider extends $FunctionalProvider<Logout, Logout, Logout>
    with $Provider<Logout> {
  LogoutProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'logoutProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$logoutHash();

  @$internal
  @override
  $ProviderElement<Logout> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Logout create(Ref ref) {
    return logout(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Logout value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Logout>(value),
    );
  }
}

String _$logoutHash() => r'cbcd2b52a07afaac9349343df36c4518410024ad';
