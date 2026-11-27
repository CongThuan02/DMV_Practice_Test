// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consent_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(consentService)
final consentServiceProvider = ConsentServiceProvider._();

final class ConsentServiceProvider
    extends $FunctionalProvider<ConsentService, ConsentService, ConsentService>
    with $Provider<ConsentService> {
  ConsentServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'consentServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$consentServiceHash();

  @$internal
  @override
  $ProviderElement<ConsentService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ConsentService create(Ref ref) {
    return consentService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConsentService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ConsentService>(value),
    );
  }
}

String _$consentServiceHash() => r'f3655c28e77a6f9094cb3704585da815081b08f3';

@ProviderFor(privacyOptionsRequired)
final privacyOptionsRequiredProvider = PrivacyOptionsRequiredProvider._();

final class PrivacyOptionsRequiredProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  PrivacyOptionsRequiredProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'privacyOptionsRequiredProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$privacyOptionsRequiredHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return privacyOptionsRequired(ref);
  }
}

String _$privacyOptionsRequiredHash() =>
    r'ec445d8152d61b68c6e6e5f2286f31093631b14d';
