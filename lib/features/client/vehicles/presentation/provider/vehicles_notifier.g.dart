// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicles_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(classificationRepository)
final classificationRepositoryProvider = ClassificationRepositoryProvider._();

final class ClassificationRepositoryProvider
    extends
        $FunctionalProvider<
          ClassificationRepository,
          ClassificationRepository,
          ClassificationRepository
        >
    with $Provider<ClassificationRepository> {
  ClassificationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'classificationRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$classificationRepositoryHash();

  @$internal
  @override
  $ProviderElement<ClassificationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ClassificationRepository create(Ref ref) {
    return classificationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClassificationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClassificationRepository>(value),
    );
  }
}

String _$classificationRepositoryHash() =>
    r'9dcc05ba5ae4e5b759b37699165dfe84db02a8d2';

@ProviderFor(ClassificationNotifier)
final classificationProvider = ClassificationNotifierProvider._();

final class ClassificationNotifierProvider
    extends $NotifierProvider<ClassificationNotifier, ClassificationState> {
  ClassificationNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'classificationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$classificationNotifierHash();

  @$internal
  @override
  ClassificationNotifier create() => ClassificationNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClassificationState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClassificationState>(value),
    );
  }
}

String _$classificationNotifierHash() =>
    r'a5b563ca154c836027fdb010e7f0556e9141e967';

abstract class _$ClassificationNotifier extends $Notifier<ClassificationState> {
  ClassificationState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ClassificationState, ClassificationState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ClassificationState, ClassificationState>,
              ClassificationState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
