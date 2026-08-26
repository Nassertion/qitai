// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(vehicleRemoteDataSource)
final vehicleRemoteDataSourceProvider = VehicleRemoteDataSourceProvider._();

final class VehicleRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          VehicleRemoteDataSource,
          VehicleRemoteDataSource,
          VehicleRemoteDataSource
        >
    with $Provider<VehicleRemoteDataSource> {
  VehicleRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vehicleRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vehicleRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<VehicleRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  VehicleRemoteDataSource create(Ref ref) {
    return vehicleRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VehicleRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VehicleRemoteDataSource>(value),
    );
  }
}

String _$vehicleRemoteDataSourceHash() =>
    r'cb2d2b26b93809612c990031d8cb7a48df185353';

@ProviderFor(vehiclesRepository)
final vehiclesRepositoryProvider = VehiclesRepositoryProvider._();

final class VehiclesRepositoryProvider
    extends
        $FunctionalProvider<
          VehiclesRepository,
          VehiclesRepository,
          VehiclesRepository
        >
    with $Provider<VehiclesRepository> {
  VehiclesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vehiclesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vehiclesRepositoryHash();

  @$internal
  @override
  $ProviderElement<VehiclesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  VehiclesRepository create(Ref ref) {
    return vehiclesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VehiclesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VehiclesRepository>(value),
    );
  }
}

String _$vehiclesRepositoryHash() =>
    r'e4759db417a0228f872f714066e8f305ce643dfc';

@ProviderFor(getCarBrands)
final getCarBrandsProvider = GetCarBrandsProvider._();

final class GetCarBrandsProvider
    extends $FunctionalProvider<GetCarBrands, GetCarBrands, GetCarBrands>
    with $Provider<GetCarBrands> {
  GetCarBrandsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getCarBrandsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getCarBrandsHash();

  @$internal
  @override
  $ProviderElement<GetCarBrands> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetCarBrands create(Ref ref) {
    return getCarBrands(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetCarBrands value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetCarBrands>(value),
    );
  }
}

String _$getCarBrandsHash() => r'6b44e41d036b85e3432623deaf81646dd20cb3a5';

@ProviderFor(getCarModels)
final getCarModelsProvider = GetCarModelsProvider._();

final class GetCarModelsProvider
    extends $FunctionalProvider<GetCarModels, GetCarModels, GetCarModels>
    with $Provider<GetCarModels> {
  GetCarModelsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getCarModelsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getCarModelsHash();

  @$internal
  @override
  $ProviderElement<GetCarModels> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetCarModels create(Ref ref) {
    return getCarModels(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetCarModels value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetCarModels>(value),
    );
  }
}

String _$getCarModelsHash() => r'd33fc744b5cdb506161289b59097f39218a19d6e';

@ProviderFor(getCarYears)
final getCarYearsProvider = GetCarYearsProvider._();

final class GetCarYearsProvider
    extends $FunctionalProvider<GetCarYears, GetCarYears, GetCarYears>
    with $Provider<GetCarYears> {
  GetCarYearsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getCarYearsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getCarYearsHash();

  @$internal
  @override
  $ProviderElement<GetCarYears> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetCarYears create(Ref ref) {
    return getCarYears(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetCarYears value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetCarYears>(value),
    );
  }
}

String _$getCarYearsHash() => r'df22f492e18910d85fb8d49f7dd61343f6ca4fbc';
