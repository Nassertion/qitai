// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_product_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CategoryProductNotifier)
final categoryProductProvider = CategoryProductNotifierFamily._();

final class CategoryProductNotifierProvider
    extends $NotifierProvider<CategoryProductNotifier, CategoryProductState> {
  CategoryProductNotifierProvider._({
    required CategoryProductNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'categoryProductProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$categoryProductNotifierHash();

  @override
  String toString() {
    return r'categoryProductProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CategoryProductNotifier create() => CategoryProductNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CategoryProductState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CategoryProductState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CategoryProductNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$categoryProductNotifierHash() =>
    r'03a96b3273af321957258532b0330b54ed69c647';

final class CategoryProductNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          CategoryProductNotifier,
          CategoryProductState,
          CategoryProductState,
          CategoryProductState,
          int
        > {
  CategoryProductNotifierFamily._()
    : super(
        retry: null,
        name: r'categoryProductProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  CategoryProductNotifierProvider call(int categoryId) =>
      CategoryProductNotifierProvider._(argument: categoryId, from: this);

  @override
  String toString() => r'categoryProductProvider';
}

abstract class _$CategoryProductNotifier
    extends $Notifier<CategoryProductState> {
  late final _$args = ref.$arg as int;
  int get categoryId => _$args;

  CategoryProductState build(int categoryId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CategoryProductState, CategoryProductState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CategoryProductState, CategoryProductState>,
              CategoryProductState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
