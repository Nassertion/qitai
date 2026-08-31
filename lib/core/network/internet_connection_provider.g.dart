// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'internet_connection_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(internetStatus)
final internetStatusProvider = InternetStatusProvider._();

final class InternetStatusProvider
    extends
        $FunctionalProvider<
          AsyncValue<InternetStatus>,
          InternetStatus,
          Stream<InternetStatus>
        >
    with $FutureModifier<InternetStatus>, $StreamProvider<InternetStatus> {
  InternetStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'internetStatusProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$internetStatusHash();

  @$internal
  @override
  $StreamProviderElement<InternetStatus> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<InternetStatus> create(Ref ref) {
    return internetStatus(ref);
  }
}

String _$internetStatusHash() => r'f5a62ef7c8d8b75be8b50d48c871e228722b05cc';
