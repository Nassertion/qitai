// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_car_vehicle_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AddCarVehicleNotifier)
final addCarVehicleProvider = AddCarVehicleNotifierProvider._();

final class AddCarVehicleNotifierProvider
    extends $NotifierProvider<AddCarVehicleNotifier, VehicleState> {
  AddCarVehicleNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addCarVehicleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addCarVehicleNotifierHash();

  @$internal
  @override
  AddCarVehicleNotifier create() => AddCarVehicleNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VehicleState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VehicleState>(value),
    );
  }
}

String _$addCarVehicleNotifierHash() =>
    r'dfedbe3b7746c8b38cea901460ac099be257bac2';

abstract class _$AddCarVehicleNotifier extends $Notifier<VehicleState> {
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
