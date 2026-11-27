// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AdsReady)
final adsReadyProvider = AdsReadyProvider._();

final class AdsReadyProvider extends $NotifierProvider<AdsReady, bool> {
  AdsReadyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adsReadyProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adsReadyHash();

  @$internal
  @override
  AdsReady create() => AdsReady();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$adsReadyHash() => r'c38eab595874d5a6bf162dd86f94fe030936212f';

abstract class _$AdsReady extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(adService)
final adServiceProvider = AdServiceProvider._();

final class AdServiceProvider
    extends $FunctionalProvider<AdService, AdService, AdService>
    with $Provider<AdService> {
  AdServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adServiceHash();

  @$internal
  @override
  $ProviderElement<AdService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AdService create(Ref ref) {
    return adService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdService>(value),
    );
  }
}

String _$adServiceHash() => r'121ae1331edecbf484eac2cd5d7e5574a01bb562';

@ProviderFor(showAds)
final showAdsProvider = ShowAdsProvider._();

final class ShowAdsProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  ShowAdsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'showAdsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$showAdsHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return showAds(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$showAdsHash() => r'bbcdb8082d732c003965f83057346efcf4d4697a';
