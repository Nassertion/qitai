// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_catalog_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(productCatalogRepository)
final productCatalogRepositoryProvider = ProductCatalogRepositoryProvider._();

final class ProductCatalogRepositoryProvider
    extends
        $FunctionalProvider<
          ProductCatalogRepository,
          ProductCatalogRepository,
          ProductCatalogRepository
        >
    with $Provider<ProductCatalogRepository> {
  ProductCatalogRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productCatalogRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productCatalogRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProductCatalogRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProductCatalogRepository create(Ref ref) {
    return productCatalogRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProductCatalogRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProductCatalogRepository>(value),
    );
  }
}

String _$productCatalogRepositoryHash() =>
    r'9c2f82085ecd576d595504b06c940a170abfcc01';
