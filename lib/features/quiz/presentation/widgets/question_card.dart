import 'package:flutter/material.dart';

import '../../../../core/widgets/asset_svg.dart';
import '../../../../data/models/question.dart';
import 'option_tile.dart';

/// Renders any of the six question types from the plan.
class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    required this.question,
    required this.selected,
    required this.reveal,
    required this.onPick,
  });

  static const blank = '___';
  static const _letters = ['A', 'B', 'C', 'D'];

  final Question question;
  final int? selected;

  /// Show right/wrong colors (practice) instead of just the selection (mock).
  final bool reveal;
  final ValueChanged<int>? onPick;

  OptionStatus _statusOf(int index) {
    if (selected == null) return OptionStatus.idle;
    if (!reveal) {
      return index == selected ? OptionStatus.selected : OptionStatus.idle;
    }
    if (index == question.answer) return OptionStatus.correct;
    if (index == selected) return OptionStatus.wrong;
    return OptionStatus.dimmed;
  }

  VoidCallback? _tapFor(int index) =>
      onPick == null ? null : () => onPick!(index);

  @override
  Widget build(BuildContext context) {
    final image = question.image;
    final questionStyle = Theme.of(
      context,
    ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (image != null) ...[
          _QuestionImage(
            path: image,
            isSign: question.type == QuestionType.sign,
          ),
          const SizedBox(height: 16),
        ],
        if (question.type == QuestionType.numberFill)
          _FillInText(
            text: question.text,
            filled: selected == null ? null : question.options[selected!].label,
            style: questionStyle,
          )
        else
          Text(question.text, style: questionStyle),
        const SizedBox(height: 16),
        if (question.type == QuestionType.numberFill)
          Row(
            children: [
              for (var i = 0; i < question.options.length; i++) ...[
                if (i > 0) const SizedBox(width: 8),
                Expanded(
                  child: OptionTile(
                    label: question.options[i].label,
                    status: _statusOf(i),
                    onTap: _tapFor(i),
                    centered: true,
                  ),
                ),
              ],
            ],
          )
        else
          for (var i = 0; i < question.options.length; i++) ...[
            if (i > 0) const SizedBox(height: 8),
            OptionTile(
              letter: _letters[i],
              label: question.options[i].label,
              leading: _optionLeading(question.options[i]),
              status: _statusOf(i),
              onTap: _tapFor(i),
            ),
          ],
      ],
    );
  }

  Widget? _optionLeading(AnswerOption option) {
    if (option.image != null) {
      return AssetSvg(option.image!, height: 44, width: 44);
    }
    if (option.color != null) {
      return Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color: option.color,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.black26),
        ),
      );
    }
    return null;
  }
}

class _QuestionImage extends StatelessWidget {
  const _QuestionImage({required this.path, required this.isSign});

  final String path;
  final bool isSign;

  @override
  Widget build(BuildContext context) {
    if (isSign) return Center(child: AssetSvg(path, height: 150));
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: AspectRatio(aspectRatio: 3 / 2, child: AssetSvg(path)),
    );
  }
}

class _FillInText extends StatelessWidget {
  const _FillInText({
    required this.text,
    required this.filled,
    required this.style,
  });

  final String text;
  final String? filled;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final parts = text.split(QuestionCard.blank);
    final primary = Theme.of(context).colorScheme.primary;
    return Text.rich(
      TextSpan(
        style: style,
        children: [
          TextSpan(text: parts.first),
          for (final part in parts.skip(1)) ...[
            TextSpan(
              text: filled == null ? ' ____ ' : ' $filled ',
              style: TextStyle(
                color: primary,
                decoration: TextDecoration.underline,
                decorationColor: primary,
                decorationThickness: 2,
              ),
            ),
            TextSpan(text: part),
          ],
        ],
      ),
    );
  }
}
