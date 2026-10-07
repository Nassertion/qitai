// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_car_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userCarRemoteDataSource)
final userCarRemoteDataSourceProvider = UserCarRemoteDataSourceProvider._();

final class UserCarRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          UserCarRemoteDataSource,
          UserCarRemoteDataSource,
          UserCarRemoteDataSource
        >
    with $Provider<UserCarRemoteDataSource> {
  UserCarRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userCarRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userCarRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<UserCarRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UserCarRemoteDataSource create(Ref ref) {
    return userCarRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserCarRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserCarRemoteDataSource>(value),
    );
  }
}

String _$userCarRemoteDataSourceHash() =>
    r'4c0f99dbe7a3ed7971386a398cae5474bf4f699e';

@ProviderFor(userCarRepository)
final userCarRepositoryProvider = UserCarRepositoryProvider._();

final class UserCarRepositoryProvider
    extends
        $FunctionalProvider<
          UserCarRepository,
          UserCarRepository,
          UserCarRepository
        >
    with $Provider<UserCarRepository> {
  UserCarRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userCarRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userCarRepositoryHash();

  @$internal
  @override
  $ProviderElement<UserCarRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UserCarRepository create(Ref ref) {
    return userCarRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserCarRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserCarRepository>(value),
    );
  }
}

String _$userCarRepositoryHash() => r'6bbc1ceedcdf5014f103c03a590404f8bd0fd317';

@ProviderFor(addUserCar)
final addUserCarProvider = AddUserCarProvider._();

final class AddUserCarProvider
    extends $FunctionalProvider<AddUserCar, AddUserCar, AddUserCar>
    with $Provider<AddUserCar> {
  AddUserCarProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addUserCarProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addUserCarHash();

  @$internal
  @override
  $ProviderElement<AddUserCar> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AddUserCar create(Ref ref) {
    return addUserCar(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AddUserCar value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AddUserCar>(value),
    );
  }
}

String _$addUserCarHash() => r'468cd2877aa361abd0c9562ac725f78e6de8d5c7';
