// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_sugesstions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(searchSuggestionsRemoteDataSource)
final searchSuggestionsRemoteDataSourceProvider =
    SearchSuggestionsRemoteDataSourceProvider._();

final class SearchSuggestionsRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          SearchSuggestionsRemoteDataSource,
          SearchSuggestionsRemoteDataSource,
          SearchSuggestionsRemoteDataSource
        >
    with $Provider<SearchSuggestionsRemoteDataSource> {
  SearchSuggestionsRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchSuggestionsRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$searchSuggestionsRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<SearchSuggestionsRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SearchSuggestionsRemoteDataSource create(Ref ref) {
    return searchSuggestionsRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchSuggestionsRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchSuggestionsRemoteDataSource>(
        value,
      ),
    );
  }
}

String _$searchSuggestionsRemoteDataSourceHash() =>
    r'a13665698f9f25cecbc83d52770e08175eb13f8b';

@ProviderFor(searchSuggestionsRepository)
final searchSuggestionsRepositoryProvider =
    SearchSuggestionsRepositoryProvider._();

final class SearchSuggestionsRepositoryProvider
    extends
        $FunctionalProvider<
          SearchSuggestionsRepository,
          SearchSuggestionsRepository,
          SearchSuggestionsRepository
        >
    with $Provider<SearchSuggestionsRepository> {
  SearchSuggestionsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchSuggestionsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchSuggestionsRepositoryHash();

  @$internal
  @override
  $ProviderElement<SearchSuggestionsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SearchSuggestionsRepository create(Ref ref) {
    return searchSuggestionsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchSuggestionsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchSuggestionsRepository>(value),
    );
  }
}

String _$searchSuggestionsRepositoryHash() =>
    r'00192b4452c41a8fd851cd383b8949ac4634cf7e';

@ProviderFor(getSuggestions)
final getSuggestionsProvider = GetSuggestionsProvider._();

final class GetSuggestionsProvider
    extends $FunctionalProvider<GetSuggestions, GetSuggestions, GetSuggestions>
    with $Provider<GetSuggestions> {
  GetSuggestionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getSuggestionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getSuggestionsHash();

  @$internal
  @override
  $ProviderElement<GetSuggestions> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetSuggestions create(Ref ref) {
    return getSuggestions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetSuggestions value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetSuggestions>(value),
    );
  }
}

String _$getSuggestionsHash() => r'4c5bd91b0d7a4cd57360c574398604b71e704c53';
