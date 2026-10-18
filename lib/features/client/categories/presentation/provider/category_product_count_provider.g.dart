// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_product_count_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(categoryProductsCount)
final categoryProductsCountProvider = CategoryProductsCountFamily._();

final class CategoryProductsCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  CategoryProductsCountProvider._({
    required CategoryProductsCountFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'categoryProductsCountProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$categoryProductsCountHash();

  @override
  String toString() {
    return r'categoryProductsCountProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    final argument = this.argument as int;
    return categoryProductsCount(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CategoryProductsCountProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$categoryProductsCountHash() =>
    r'426e2805a6989d29738042a95548a5e43cdc32bf';

final class CategoryProductsCountFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<int>, int> {
  CategoryProductsCountFamily._()
    : super(
        retry: null,
        name: r'categoryProductsCountProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  CategoryProductsCountProvider call(int categoryId) =>
      CategoryProductsCountProvider._(argument: categoryId, from: this);

  @override
  String toString() => r'categoryProductsCountProvider';
}
