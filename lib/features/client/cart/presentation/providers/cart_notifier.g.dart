// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(cartLocalDataSource)
final cartLocalDataSourceProvider = CartLocalDataSourceProvider._();

final class CartLocalDataSourceProvider
    extends
        $FunctionalProvider<
          CartLocalDataSource,
          CartLocalDataSource,
          CartLocalDataSource
        >
    with $Provider<CartLocalDataSource> {
  CartLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cartLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cartLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<CartLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CartLocalDataSource create(Ref ref) {
    return cartLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CartLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CartLocalDataSource>(value),
    );
  }
}

String _$cartLocalDataSourceHash() =>
    r'4e76c54918b99a23cf7cfd6e94427a68a4de28d2';

@ProviderFor(CartNotifier)
final cartProvider = CartNotifierProvider._();

final class CartNotifierProvider
    extends $AsyncNotifierProvider<CartNotifier, List<LocalCartItem>> {
  CartNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cartProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cartNotifierHash();

  @$internal
  @override
  CartNotifier create() => CartNotifier();
}

String _$cartNotifierHash() => r'c8153d0cec6500d748e789fd4c8ee55407778622';

abstract class _$CartNotifier extends $AsyncNotifier<List<LocalCartItem>> {
  FutureOr<List<LocalCartItem>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<LocalCartItem>>, List<LocalCartItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<LocalCartItem>>, List<LocalCartItem>>,
              AsyncValue<List<LocalCartItem>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
