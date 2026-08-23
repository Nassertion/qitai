// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_provider.dart';

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

@ProviderFor(productDetailsRepository)
final productDetailsRepositoryProvider = ProductDetailsRepositoryProvider._();

final class ProductDetailsRepositoryProvider
    extends
        $FunctionalProvider<
          ProductDetailsRepository,
          ProductDetailsRepository,
          ProductDetailsRepository
        >
    with $Provider<ProductDetailsRepository> {
  ProductDetailsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productDetailsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productDetailsRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProductDetailsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProductDetailsRepository create(Ref ref) {
    return productDetailsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProductDetailsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProductDetailsRepository>(value),
    );
  }
}

String _$productDetailsRepositoryHash() =>
    r'60984303993b7f221ce723630f5b84f1e58caed1';

@ProviderFor(getProductDetails)
final getProductDetailsProvider = GetProductDetailsProvider._();

final class GetProductDetailsProvider
    extends
        $FunctionalProvider<
          GetProductDetails,
          GetProductDetails,
          GetProductDetails
        >
    with $Provider<GetProductDetails> {
  GetProductDetailsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getProductDetailsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getProductDetailsHash();

  @$internal
  @override
  $ProviderElement<GetProductDetails> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetProductDetails create(Ref ref) {
    return getProductDetails(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetProductDetails value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetProductDetails>(value),
    );
  }
}

String _$getProductDetailsHash() => r'a2e9e13f50f89a0b5c382630b0fc8c1b7514f95d';

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

String _$productDetailHash() => r'3d1c5cdb4cb790d480c36de98812975b20bc8e2c';

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
