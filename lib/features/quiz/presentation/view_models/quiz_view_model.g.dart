// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(QuizViewModel)
final quizViewModelProvider = QuizViewModelFamily._();

final class QuizViewModelProvider
    extends $AsyncNotifierProvider<QuizViewModel, QuizState> {
  QuizViewModelProvider._({
    required QuizViewModelFamily super.from,
    required (QuizMode, String?) super.argument,
  }) : super(
         retry: _retryUnlessEmpty,
         name: r'quizViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$quizViewModelHash();

  @override
  String toString() {
    return r'quizViewModelProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  QuizViewModel create() => QuizViewModel();

  @override
  bool operator ==(Object other) {
    return other is QuizViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$quizViewModelHash() => r'e57d03d67b8224fe571c0a9e4fe8d83b2c29ba3b';

final class QuizViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          QuizViewModel,
          AsyncValue<QuizState>,
          QuizState,
          FutureOr<QuizState>,
          (QuizMode, String?)
        > {
  QuizViewModelFamily._()
    : super(
        retry: _retryUnlessEmpty,
        name: r'quizViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  QuizViewModelProvider call(QuizMode mode, String? topic) =>
      QuizViewModelProvider._(argument: (mode, topic), from: this);

  @override
  String toString() => r'quizViewModelProvider';
}

abstract class _$QuizViewModel extends $AsyncNotifier<QuizState> {
  late final _$args = ref.$arg as (QuizMode, String?);
  QuizMode get mode => _$args.$1;
  String? get topic => _$args.$2;

  FutureOr<QuizState> build(QuizMode mode, String? topic);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<QuizState>, QuizState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<QuizState>, QuizState>,
              AsyncValue<QuizState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
