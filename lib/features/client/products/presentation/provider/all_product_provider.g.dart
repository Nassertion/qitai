// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_product_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AllProductsNotifier)
final allProductsProvider = AllProductsNotifierProvider._();

final class AllProductsNotifierProvider
    extends $NotifierProvider<AllProductsNotifier, AllProductsState> {
  AllProductsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allProductsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allProductsNotifierHash();

  @$internal
  @override
  AllProductsNotifier create() => AllProductsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AllProductsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AllProductsState>(value),
    );
  }
}

String _$allProductsNotifierHash() =>
    r'55d04a7b3ae16b7fc9dbac65278d23cdaa734288';

abstract class _$AllProductsNotifier extends $Notifier<AllProductsState> {
  AllProductsState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AllProductsState, AllProductsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AllProductsState, AllProductsState>,
              AllProductsState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
