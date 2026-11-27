// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pro_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Loads the store product; `null` means the store or product is unavailable.

@ProviderFor(ProViewModel)
final proViewModelProvider = ProViewModelProvider._();

/// Loads the store product; `null` means the store or product is unavailable.
final class ProViewModelProvider
    extends $AsyncNotifierProvider<ProViewModel, ProductDetails?> {
  /// Loads the store product; `null` means the store or product is unavailable.
  ProViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'proViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$proViewModelHash();

  @$internal
  @override
  ProViewModel create() => ProViewModel();
}

String _$proViewModelHash() => r'88568cd31909f9fdc33bdddf83decd304e881882';

/// Loads the store product; `null` means the store or product is unavailable.

abstract class _$ProViewModel extends $AsyncNotifier<ProductDetails?> {
  FutureOr<ProductDetails?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ProductDetails?>, ProductDetails?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ProductDetails?>, ProductDetails?>,
              AsyncValue<ProductDetails?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
