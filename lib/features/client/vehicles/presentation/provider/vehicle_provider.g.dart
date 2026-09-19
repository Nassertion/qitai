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

@ProviderFor(vehicleRepository)
final vehicleRepositoryProvider = VehicleRepositoryProvider._();

final class VehicleRepositoryProvider
    extends
        $FunctionalProvider<
          VehicleRepository,
          VehicleRepository,
          VehicleRepository
        >
    with $Provider<VehicleRepository> {
  VehicleRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vehicleRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vehicleRepositoryHash();

  @$internal
  @override
  $ProviderElement<VehicleRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  VehicleRepository create(Ref ref) {
    return vehicleRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VehicleRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VehicleRepository>(value),
    );
  }
}

String _$vehicleRepositoryHash() => r'5295a0169ae47d93509e37ad359b3af9dbfab94b';

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

String _$getCarBrandsHash() => r'ee9cbf1c19105bcbec89230204cc97afd1a9ed46';

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

String _$getCarModelsHash() => r'17a0e2786ed13c8f05149d38093d292737099798';

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

String _$getCarYearsHash() => r'c146c059e12374146d65d8dfd6cd71f43b6847b2';
