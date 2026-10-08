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

@ProviderFor(getUserCars)
final getUserCarsProvider = GetUserCarsProvider._();

final class GetUserCarsProvider
    extends $FunctionalProvider<GetUserCars, GetUserCars, GetUserCars>
    with $Provider<GetUserCars> {
  GetUserCarsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getUserCarsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getUserCarsHash();

  @$internal
  @override
  $ProviderElement<GetUserCars> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetUserCars create(Ref ref) {
    return getUserCars(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetUserCars value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetUserCars>(value),
    );
  }
}

String _$getUserCarsHash() => r'5ed58d7b73fb7fe1ae9798f8ded862358a5dc0a8';

@ProviderFor(userCars)
final userCarsProvider = UserCarsProvider._();

final class UserCarsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<UserCar>>,
          List<UserCar>,
          FutureOr<List<UserCar>>
        >
    with $FutureModifier<List<UserCar>>, $FutureProvider<List<UserCar>> {
  UserCarsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userCarsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userCarsHash();

  @$internal
  @override
  $FutureProviderElement<List<UserCar>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<UserCar>> create(Ref ref) {
    return userCars(ref);
  }
}

String _$userCarsHash() => r'ff25d9bb340532f3cf7238574d6d9ef4b95aba75';

@ProviderFor(deleteUserCar)
final deleteUserCarProvider = DeleteUserCarProvider._();

final class DeleteUserCarProvider
    extends $FunctionalProvider<DeleteUserCar, DeleteUserCar, DeleteUserCar>
    with $Provider<DeleteUserCar> {
  DeleteUserCarProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteUserCarProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteUserCarHash();

  @$internal
  @override
  $ProviderElement<DeleteUserCar> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DeleteUserCar create(Ref ref) {
    return deleteUserCar(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteUserCar value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteUserCar>(value),
    );
  }
}

String _$deleteUserCarHash() => r'e78e4ac5bdafe04a83569b3d00b841231869fb94';

@ProviderFor(setDefaultUserCar)
final setDefaultUserCarProvider = SetDefaultUserCarProvider._();

final class SetDefaultUserCarProvider
    extends
        $FunctionalProvider<
          SetDefaultUserCar,
          SetDefaultUserCar,
          SetDefaultUserCar
        >
    with $Provider<SetDefaultUserCar> {
  SetDefaultUserCarProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'setDefaultUserCarProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$setDefaultUserCarHash();

  @$internal
  @override
  $ProviderElement<SetDefaultUserCar> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SetDefaultUserCar create(Ref ref) {
    return setDefaultUserCar(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SetDefaultUserCar value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SetDefaultUserCar>(value),
    );
  }
}

String _$setDefaultUserCarHash() => r'ee21ff71e26901d77cc83c2714e85966af3e231b';
