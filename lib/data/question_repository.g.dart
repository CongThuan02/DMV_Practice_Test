// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(questionRepository)
final questionRepositoryProvider = QuestionRepositoryProvider._();

final class QuestionRepositoryProvider
    extends
        $FunctionalProvider<
          QuestionRepository,
          QuestionRepository,
          QuestionRepository
        >
    with $Provider<QuestionRepository> {
  QuestionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'questionRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$questionRepositoryHash();

  @$internal
  @override
  $ProviderElement<QuestionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  QuestionRepository create(Ref ref) {
    return questionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(QuestionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<QuestionRepository>(value),
    );
  }
}

String _$questionRepositoryHash() =>
    r'a3876ab7a72dc0fc74e862aef64fca855e3413b1';
