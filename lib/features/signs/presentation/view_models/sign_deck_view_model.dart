import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../data/models/question.dart';
import '../../../../data/session_providers.dart';

part 'sign_deck_view_model.g.dart';

class SignDeckState {
  const SignDeckState({
    required this.remaining,
    required this.total,
    this.flipped = false,
  });

  final List<Question> remaining;
  final int total;
  final bool flipped;

  Question get current => remaining.first;
  bool get isDone => remaining.isEmpty;
  int get learned => total - remaining.length;
}

/// "Got it" removes the card; "Still learning" moves it to the back.
@riverpod
class SignDeckViewModel extends _$SignDeckViewModel {
  @override
  Future<SignDeckState> build() async {
    final bank = await ref.watch(stateBankProvider.future);
    final cards = [...bank.byType(QuestionType.sign)]
      ..shuffle(ref.read(randomProvider));
    return SignDeckState(remaining: cards, total: cards.length);
  }

  void flip() => _update(
    (s) => SignDeckState(
      remaining: s.remaining,
      total: s.total,
      flipped: !s.flipped,
    ),
  );

  void gotIt() => _update(
    (s) => SignDeckState(remaining: s.remaining.sublist(1), total: s.total),
  );

  void stillLearning() => _update(
    (s) => SignDeckState(
      remaining: [...s.remaining.sublist(1), s.current],
      total: s.total,
    ),
  );

  void restart() => ref.invalidateSelf();

  void _update(SignDeckState Function(SignDeckState) change) {
    final current = state.value;
    if (current == null || current.isDone) return;
    state = AsyncData(change(current));
  }
}
