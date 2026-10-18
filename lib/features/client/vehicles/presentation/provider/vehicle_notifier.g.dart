// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VehicleNotifier)
final vehicleProvider = VehicleNotifierFamily._();

final class VehicleNotifierProvider
    extends $NotifierProvider<VehicleNotifier, VehicleState> {
  VehicleNotifierProvider._({
    required VehicleNotifierFamily super.from,
    required VehicleScope super.argument,
  }) : super(
         retry: null,
         name: r'vehicleProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$vehicleNotifierHash();

  @override
  String toString() {
    return r'vehicleProvider'
        ''
        '($argument)';
  }

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

  @override
  bool operator ==(Object other) {
    return other is VehicleNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$vehicleNotifierHash() => r'ba0ba2802b4b069847194d34d983eae4793901f6';

final class VehicleNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          VehicleNotifier,
          VehicleState,
          VehicleState,
          VehicleState,
          VehicleScope
        > {
  VehicleNotifierFamily._()
    : super(
        retry: null,
        name: r'vehicleProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  VehicleNotifierProvider call(VehicleScope scope) =>
      VehicleNotifierProvider._(argument: scope, from: this);

  @override
  String toString() => r'vehicleProvider';
}

abstract class _$VehicleNotifier extends $Notifier<VehicleState> {
  late final _$args = ref.$arg as VehicleScope;
  VehicleScope get scope => _$args;

  VehicleState build(VehicleScope scope);
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
    return element.handleCreate(ref, () => build(_$args));
  }
}
