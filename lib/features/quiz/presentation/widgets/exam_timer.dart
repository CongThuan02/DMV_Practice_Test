import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/session_providers.dart';
import '../view_models/quiz_state.dart';

String formatDuration(Duration d) {
  final minutes = d.inMinutes.toString().padLeft(2, '0');
  final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
  return d.inHours > 0 ? '${d.inHours}:$minutes:$seconds' : '$minutes:$seconds';
}

class ExamTimer extends ConsumerStatefulWidget {
  const ExamTimer({super.key, required this.state});

  final QuizState state;

  @override
  ConsumerState<ExamTimer> createState() => _ExamTimerState();
}

class _ExamTimerState extends ConsumerState<ExamTimer> {
  late final Timer _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted && !widget.state.isPaused) setState(() {});
    });
  }

  @override
  void dispose() {
    _ticker.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final elapsed = widget.state.elapsedAt(ref.read(clockProvider)());
    return Text(
      '⏱ ${formatDuration(elapsed)}',
      style: const TextStyle(fontFeatures: [FontFeature.tabularFigures()]),
    );
  }
}
