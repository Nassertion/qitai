// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'similar_products_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(similarProducts)
final similarProductsProvider = SimilarProductsFamily._();

final class SimilarProductsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Product>>,
          List<Product>,
          FutureOr<List<Product>>
        >
    with $FutureModifier<List<Product>>, $FutureProvider<List<Product>> {
  SimilarProductsProvider._({
    required SimilarProductsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'similarProductsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$similarProductsHash();

  @override
  String toString() {
    return r'similarProductsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Product>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Product>> create(Ref ref) {
    final argument = this.argument as int;
    return similarProducts(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SimilarProductsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$similarProductsHash() => r'966c2722fb185557f4eb1f46adf267efe5d472aa';

final class SimilarProductsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Product>>, int> {
  SimilarProductsFamily._()
    : super(
        retry: null,
        name: r'similarProductsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SimilarProductsProvider call(int currentProductId) =>
      SimilarProductsProvider._(argument: currentProductId, from: this);

  @override
  String toString() => r'similarProductsProvider';
}
