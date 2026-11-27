// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(progressStore)
final progressStoreProvider = ProgressStoreProvider._();

final class ProgressStoreProvider
    extends $FunctionalProvider<ProgressStore, ProgressStore, ProgressStore>
    with $Provider<ProgressStore> {
  ProgressStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'progressStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$progressStoreHash();

  @$internal
  @override
  $ProviderElement<ProgressStore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ProgressStore create(Ref ref) {
    return progressStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProgressStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProgressStore>(value),
    );
  }
}

String _$progressStoreHash() => r'8007103344733c04b4538fa5d3782bbb8601a1b2';
