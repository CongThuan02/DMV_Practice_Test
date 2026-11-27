import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/disclaimer_text.dart';
import '../../../../data/session_providers.dart';
import '../view_models/startup_view_model.dart';

class StartupPage extends ConsumerStatefulWidget {
  const StartupPage({super.key});

  @override
  ConsumerState<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends ConsumerState<StartupPage> {
  @override
  void initState() {
    super.initState();
    ref.listenManual(startupViewModelProvider, (_, next) {
      if (next.isLoading) return;
      final hasState = ref.read(selectedStateProvider) != null;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.go(hasState ? AppRoutes.home : AppRoutes.states);
      });
    }, fireImmediately: true);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              const Text('🚗', style: TextStyle(fontSize: 56)),
              const SizedBox(height: 12),
              Text(
                LocaleKeys.app_title.tr(),
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const DisclaimerText(),
              const SizedBox(height: 32),
              const CircularProgressIndicator(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
