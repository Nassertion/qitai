// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicles_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(vehicleRepository)
final vehicleRepositoryProvider = VehicleRepositoryProvider._();

final class VehicleRepositoryProvider
    extends
        $FunctionalProvider<
          VehicleRepository1,
          VehicleRepository1,
          VehicleRepository1
        >
    with $Provider<VehicleRepository1> {
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
  $ProviderElement<VehicleRepository1> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  VehicleRepository1 create(Ref ref) {
    return vehicleRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VehicleRepository1 value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VehicleRepository1>(value),
    );
  }
}

String _$vehicleRepositoryHash() => r'ba3fd7aa41bed628bff3fec4197128d18880a3c6';

@ProviderFor(VehicleNotifier)
final vehicleProvider = VehicleNotifierProvider._();

final class VehicleNotifierProvider
    extends $NotifierProvider<VehicleNotifier, VehicleState> {
  VehicleNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vehicleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vehicleNotifierHash();

  @$internal
  @override
  VehicleNotifier create() => VehicleNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VehicleState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VehicleState>(value),
    );
  }
}

String _$vehicleNotifierHash() => r'733a0e08517a11d9a584df0c27648636529bb9b6';

abstract class _$VehicleNotifier extends $Notifier<VehicleState> {
  VehicleState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<VehicleState, VehicleState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<VehicleState, VehicleState>,
              VehicleState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
