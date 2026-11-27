// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'startup_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Consent first, then ads (UMP requirement). Failures never block the app:
/// it must keep working offline and without ads.

@ProviderFor(StartupViewModel)
final startupViewModelProvider = StartupViewModelProvider._();

/// Consent first, then ads (UMP requirement). Failures never block the app:
/// it must keep working offline and without ads.
final class StartupViewModelProvider
    extends $AsyncNotifierProvider<StartupViewModel, void> {
  /// Consent first, then ads (UMP requirement). Failures never block the app:
  /// it must keep working offline and without ads.
  StartupViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'startupViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$startupViewModelHash();

  @$internal
  @override
  StartupViewModel create() => StartupViewModel();
}

String _$startupViewModelHash() => r'ae05bc0fc4d2bbad1312138dac2d32319774bb90';

/// Consent first, then ads (UMP requirement). Failures never block the app:
/// it must keep working offline and without ads.

abstract class _$StartupViewModel extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
