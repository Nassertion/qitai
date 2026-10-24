// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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

String _$vehicleNotifierHash() => r'b8541862f487965116443c1d1e737b1b1f8bf0c2';

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
