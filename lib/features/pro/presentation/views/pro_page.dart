import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/widgets/menu_card.dart';
import '../../../../data/session_providers.dart';
import '../../../../services/purchase_service.dart';
import '../view_models/pro_view_model.dart';

class ProPage extends ConsumerStatefulWidget {
  const ProPage({super.key});

  @override
  ConsumerState<ProPage> createState() => _ProPageState();
}

class _ProPageState extends ConsumerState<ProPage> {
  StreamSubscription<PurchaseEvent>? _events;

  @override
  void initState() {
    super.initState();
    _events = ref.read(purchaseServiceProvider).events.listen((event) {
      if (!mounted) return;
      final message = switch (event) {
        PurchaseEvent.pending => LocaleKeys.pro_pending.tr(),
        PurchaseEvent.unlocked => LocaleKeys.pro_thanks.tr(),
        PurchaseEvent.canceled => LocaleKeys.pro_canceled.tr(),
        PurchaseEvent.failed => LocaleKeys.pro_failed.tr(),
      };
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(message)));
    });
  }

  @override
  void dispose() {
    _events?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPro = ref.watch(proStatusProvider);
    final product = ref.watch(proViewModelProvider);
    final notifier = ref.read(proViewModelProvider.notifier);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.pro_title.tr())),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          MenuCard(
            leading: '🚫',
            title: LocaleKeys.pro_no_ads.tr(),
            subtitle: LocaleKeys.pro_no_ads_subtitle.tr(),
          ),
          const SizedBox(height: 8),
          MenuCard(
            leading: '💡',
            title: LocaleKeys.pro_explanations.tr(),
            subtitle: LocaleKeys.pro_explanations_subtitle.tr(),
          ),
          const SizedBox(height: 8),
          MenuCard(
            leading: '📴',
            title: LocaleKeys.pro_offline.tr(),
            subtitle: LocaleKeys.pro_offline_subtitle.tr(),
          ),
          const SizedBox(height: 24),
          if (isPro)
            Text(
              LocaleKeys.pro_unlocked.tr(),
              textAlign: TextAlign.center,
              style: textTheme.titleMedium,
            )
          else ...[
            product.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) => Text(
                LocaleKeys.pro_store_unavailable.tr(),
                textAlign: TextAlign.center,
              ),
              data: (p) => Text(
                p == null
                    ? LocaleKeys.pro_store_unavailable.tr()
                    : LocaleKeys.pro_price.tr(args: [p.price]),
                textAlign: TextAlign.center,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: product.value == null ? null : notifier.buy,
              child: Text(LocaleKeys.pro_buy.tr()),
            ),
          ],
          const SizedBox(height: 8),
          TextButton(
            onPressed: notifier.restore,
            child: Text(LocaleKeys.pro_restore.tr()),
          ),
        ],
      ),
    );
  }
}
