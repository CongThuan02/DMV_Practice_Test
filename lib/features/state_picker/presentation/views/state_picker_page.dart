import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/error_retry_view.dart';
import '../../../../data/session_providers.dart';
import '../../../../data/state_catalog.dart';

class StatePickerPage extends ConsumerStatefulWidget {
  const StatePickerPage({super.key});

  @override
  ConsumerState<StatePickerPage> createState() => _StatePickerPageState();
}

class _StatePickerPageState extends ConsumerState<StatePickerPage> {
  String _query = '';

  Future<void> _select(UsState state) async {
    await ref.read(selectedStateProvider.notifier).select(state.code);
    if (mounted) context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final available = ref.watch(availableStatesProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(LocaleKeys.states_title.tr()),
            Text(
              LocaleKeys.states_subtitle.tr(),
              style: textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
      body: available.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => ErrorRetryView(
          onRetry: () => ref.invalidate(availableStatesProvider),
        ),
        data: (codes) {
          final query = _query.trim().toLowerCase();
          bool matches(UsState s) =>
              query.isEmpty ||
              s.name.toLowerCase().contains(query) ||
              s.code.toLowerCase() == query;
          final popular = [
            for (final code in StateCatalog.popularCodes)
              if (StateCatalog.byCode(code) case final s? when matches(s)) s,
          ];
          final all = StateCatalog.all.where(matches).toList();

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              TextField(
                autofocus: false,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: LocaleKeys.states_search_hint.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) => setState(() => _query = value),
              ),
              if (popular.isNotEmpty) ...[
                _SectionLabel(LocaleKeys.states_popular.tr()),
                for (final s in popular)
                  _StateTile(
                    state: s,
                    available: codes.contains(s.code),
                    onTap: () => _select(s),
                  ),
              ],
              _SectionLabel(LocaleKeys.states_all.tr()),
              for (final s in all)
                _StateTile(
                  state: s,
                  available: codes.contains(s.code),
                  onTap: () => _select(s),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 4),
      child: Text(
        text.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          letterSpacing: 0.6,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _StateTile extends StatelessWidget {
  const _StateTile({
    required this.state,
    required this.available,
    required this.onTap,
  });

  final UsState state;
  final bool available;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      enabled: available,
      title: Text(state.name),
      trailing: available
          ? Icon(Icons.chevron_right, color: muted)
          : Text(
              LocaleKeys.states_coming_soon.tr(),
              style: TextStyle(color: muted),
            ),
      onTap: available ? onTap : null,
    );
  }
}
