import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../services/ad_config.dart';
import '../../services/ad_service.dart';

/// Adaptive anchored banner. Renders nothing for PRO users, before consent,
/// or when no ad could be loaded (offline).
class AdBanner extends ConsumerWidget {
  const AdBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!ref.watch(showAdsProvider)) return const SizedBox.shrink();
    return const SafeArea(top: false, child: _LoadedBanner());
  }
}

class _LoadedBanner extends StatefulWidget {
  const _LoadedBanner();

  @override
  State<_LoadedBanner> createState() => _LoadedBannerState();
}

class _LoadedBannerState extends State<_LoadedBanner> {
  BannerAd? _ad;
  bool _loaded = false;
  int? _requestedWidth;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final width = MediaQuery.sizeOf(context).width.truncate();
    if (width != _requestedWidth) _load(width);
  }

  Future<void> _load(int width) async {
    _requestedWidth = width;
    final size = await AdSize.getLargeAnchoredAdaptiveBannerAdSize(width);
    if (!mounted || size == null) return;
    await _ad?.dispose();
    _loaded = false;
    _ad = BannerAd(
      adUnitId: AdConfig.banner,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          if (mounted) setState(() => _loaded = true);
        },
        onAdFailedToLoad: (ad, _) => ad.dispose(),
      ),
    )..load();
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ad = _ad;
    if (ad == null || !_loaded) return const SizedBox.shrink();
    return SizedBox(
      width: ad.size.width.toDouble(),
      height: ad.size.height.toDouble(),
      child: AdWidget(ad: ad),
    );
  }
}
