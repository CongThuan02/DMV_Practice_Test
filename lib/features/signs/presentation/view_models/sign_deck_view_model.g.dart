// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_deck_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// "Got it" removes the card; "Still learning" moves it to the back.

@ProviderFor(SignDeckViewModel)
final signDeckViewModelProvider = SignDeckViewModelProvider._();

/// "Got it" removes the card; "Still learning" moves it to the back.
final class SignDeckViewModelProvider
    extends $AsyncNotifierProvider<SignDeckViewModel, SignDeckState> {
  /// "Got it" removes the card; "Still learning" moves it to the back.
  SignDeckViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signDeckViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signDeckViewModelHash();

  @$internal
  @override
  SignDeckViewModel create() => SignDeckViewModel();
}

String _$signDeckViewModelHash() => r'06a4cc7fe7d5a7685a2195ef5cc81c63b4876a43';

/// "Got it" removes the card; "Still learning" moves it to the back.

abstract class _$SignDeckViewModel extends $AsyncNotifier<SignDeckState> {
  FutureOr<SignDeckState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<SignDeckState>, SignDeckState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SignDeckState>, SignDeckState>,
              AsyncValue<SignDeckState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
