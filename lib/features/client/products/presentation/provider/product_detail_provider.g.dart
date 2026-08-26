// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(productDetailRemoteDataSource)
final productDetailRemoteDataSourceProvider =
    ProductDetailRemoteDataSourceProvider._();

final class ProductDetailRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          ProductDetailRemoteDataSource,
          ProductDetailRemoteDataSource,
          ProductDetailRemoteDataSource
        >
    with $Provider<ProductDetailRemoteDataSource> {
  ProductDetailRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productDetailRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productDetailRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<ProductDetailRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProductDetailRemoteDataSource create(Ref ref) {
    return productDetailRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProductDetailRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProductDetailRemoteDataSource>(
        value,
      ),
    );
  }
}

String _$productDetailRemoteDataSourceHash() =>
    r'4d33ded9f9b1668e6f42d4882b280e179c924da1';

@ProviderFor(productDetailRepository)
final productDetailRepositoryProvider = ProductDetailRepositoryProvider._();

final class ProductDetailRepositoryProvider
    extends
        $FunctionalProvider<
          ProductDetailRepository,
          ProductDetailRepository,
          ProductDetailRepository
        >
    with $Provider<ProductDetailRepository> {
  ProductDetailRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productDetailRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productDetailRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProductDetailRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProductDetailRepository create(Ref ref) {
    return productDetailRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProductDetailRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProductDetailRepository>(value),
    );
  }
}

String _$productDetailRepositoryHash() =>
    r'49125ca08fe44265e9db75ecdd13f5f2400c3ee8';

@ProviderFor(getProductDetail)
final getProductDetailProvider = GetProductDetailProvider._();

final class GetProductDetailProvider
    extends
        $FunctionalProvider<
          GetProductDetail,
          GetProductDetail,
          GetProductDetail
        >
    with $Provider<GetProductDetail> {
  GetProductDetailProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getProductDetailProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getProductDetailHash();

  @$internal
  @override
  $ProviderElement<GetProductDetail> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetProductDetail create(Ref ref) {
    return getProductDetail(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetProductDetail value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetProductDetail>(value),
    );
  }
}

String _$getProductDetailHash() => r'ac8976262ce8699f40ba84a64a65ac1dc0b27bf6';

@ProviderFor(productDetail)
final productDetailProvider = ProductDetailFamily._();

final class ProductDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<ProductDetail>,
          ProductDetail,
          FutureOr<ProductDetail>
        >
    with $FutureModifier<ProductDetail>, $FutureProvider<ProductDetail> {
  ProductDetailProvider._({
    required ProductDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'productDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$productDetailHash();

  @override
  String toString() {
    return r'productDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ProductDetail> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ProductDetail> create(Ref ref) {
    final argument = this.argument as int;
    return productDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productDetailHash() => r'29afd56f4875f05354722cd419e17269d9ca0e78';

final class ProductDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ProductDetail>, int> {
  ProductDetailFamily._()
    : super(
        retry: null,
        name: r'productDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProductDetailProvider call(int productId) =>
      ProductDetailProvider._(argument: productId, from: this);

  @override
  String toString() => r'productDetailProvider';
}
