// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_suggestions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(searchSuggestionRemoteDataSource)
final searchSuggestionRemoteDataSourceProvider =
    SearchSuggestionRemoteDataSourceProvider._();

final class SearchSuggestionRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          SearchSuggestionRemoteDataSource,
          SearchSuggestionRemoteDataSource,
          SearchSuggestionRemoteDataSource
        >
    with $Provider<SearchSuggestionRemoteDataSource> {
  SearchSuggestionRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchSuggestionRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchSuggestionRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<SearchSuggestionRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SearchSuggestionRemoteDataSource create(Ref ref) {
    return searchSuggestionRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchSuggestionRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchSuggestionRemoteDataSource>(
        value,
      ),
    );
  }
}

String _$searchSuggestionRemoteDataSourceHash() =>
    r'6e284d52658ee79d38bb2ef45f287f95d4c43ec8';

@ProviderFor(searchSuggestionRepository)
final searchSuggestionRepositoryProvider =
    SearchSuggestionRepositoryProvider._();

final class SearchSuggestionRepositoryProvider
    extends
        $FunctionalProvider<
          SearchSuggestionRepository,
          SearchSuggestionRepository,
          SearchSuggestionRepository
        >
    with $Provider<SearchSuggestionRepository> {
  SearchSuggestionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchSuggestionRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchSuggestionRepositoryHash();

  @$internal
  @override
  $ProviderElement<SearchSuggestionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SearchSuggestionRepository create(Ref ref) {
    return searchSuggestionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchSuggestionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchSuggestionRepository>(value),
    );
  }
}

String _$searchSuggestionRepositoryHash() =>
    r'd89756f1d9eaa6d2aaf94da571805e8ed9775384';

@ProviderFor(getSearchSuggestions)
final getSearchSuggestionsProvider = GetSearchSuggestionsProvider._();

final class GetSearchSuggestionsProvider
    extends
        $FunctionalProvider<
          GetSearchSuggestions,
          GetSearchSuggestions,
          GetSearchSuggestions
        >
    with $Provider<GetSearchSuggestions> {
  GetSearchSuggestionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getSearchSuggestionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getSearchSuggestionsHash();

  @$internal
  @override
  $ProviderElement<GetSearchSuggestions> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetSearchSuggestions create(Ref ref) {
    return getSearchSuggestions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetSearchSuggestions value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetSearchSuggestions>(value),
    );
  }
}

String _$getSearchSuggestionsHash() =>
    r'75fe93fc65bc803eb99c8ac3dec6fbbae8b04c92';
