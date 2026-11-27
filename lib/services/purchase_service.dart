import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/session_providers.dart';

part 'purchase_service.g.dart';

enum PurchaseEvent { pending, unlocked, canceled, failed }

/// One non-consumable product removes ads and unlocks explanations.
/// Price is configured in Play Console / App Store Connect, never in code.
class PurchaseService {
  PurchaseService(this._ref, this._iap);

  static const productId = 'remove_ads';

  final Ref _ref;
  final InAppPurchase _iap;
  final _events = StreamController<PurchaseEvent>.broadcast();
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  Stream<PurchaseEvent> get events => _events.stream;

  /// Listens for purchase updates and restores past purchases so PRO is
  /// re-synced from the store on every launch.
  Future<void> start() async {
    if (_subscription != null || !await _iap.isAvailable()) return;
    _subscription = _iap.purchaseStream.listen(
      _handle,
      onError: (_) => _events.add(PurchaseEvent.failed),
    );
    await _iap.restorePurchases();
  }

  Future<ProductDetails?> loadProduct() async {
    if (!await _iap.isAvailable()) return null;
    final response = await _iap.queryProductDetails({productId});
    return response.productDetails.isEmpty
        ? null
        : response.productDetails.first;
  }

  Future<void> buy(ProductDetails product) => _iap.buyNonConsumable(
    purchaseParam: PurchaseParam(productDetails: product),
  );

  Future<void> restore() => _iap.restorePurchases();

  Future<void> _handle(List<PurchaseDetails> purchases) async {
    for (final purchase in purchases) {
      if (purchase.productID != productId) continue;
      switch (purchase.status) {
        case PurchaseStatus.pending:
          _events.add(PurchaseEvent.pending);
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          await _ref.read(proStatusProvider.notifier).unlock();
          _events.add(PurchaseEvent.unlocked);
        case PurchaseStatus.canceled:
          _events.add(PurchaseEvent.canceled);
        case PurchaseStatus.error:
          _events.add(PurchaseEvent.failed);
      }
      if (purchase.pendingCompletePurchase) {
        await _iap.completePurchase(purchase);
      }
    }
  }
}

@Riverpod(keepAlive: true)
PurchaseService purchaseService(Ref ref) =>
    PurchaseService(ref, InAppPurchase.instance);
