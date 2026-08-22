// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_product_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CategorySearchNotifier)
final categorySearchProvider = CategorySearchNotifierFamily._();

final class CategorySearchNotifierProvider
    extends $NotifierProvider<CategorySearchNotifier, CategorySearchState> {
  CategorySearchNotifierProvider._({
    required CategorySearchNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'categorySearchProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$categorySearchNotifierHash();

  @override
  String toString() {
    return r'categorySearchProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CategorySearchNotifier create() => CategorySearchNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CategorySearchState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CategorySearchState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CategorySearchNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$categorySearchNotifierHash() =>
    r'8e596274d454bc1d91807ed3375c57c21103b313';

final class CategorySearchNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          CategorySearchNotifier,
          CategorySearchState,
          CategorySearchState,
          CategorySearchState,
          int
        > {
  CategorySearchNotifierFamily._()
    : super(
        retry: null,
        name: r'categorySearchProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CategorySearchNotifierProvider call(int categoryId) =>
      CategorySearchNotifierProvider._(argument: categoryId, from: this);

  @override
  String toString() => r'categorySearchProvider';
}

abstract class _$CategorySearchNotifier extends $Notifier<CategorySearchState> {
  late final _$args = ref.$arg as int;
  int get categoryId => _$args;

  CategorySearchState build(int categoryId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CategorySearchState, CategorySearchState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CategorySearchState, CategorySearchState>,
              CategorySearchState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
