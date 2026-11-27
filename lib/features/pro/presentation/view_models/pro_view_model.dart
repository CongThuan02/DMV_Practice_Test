import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../services/purchase_service.dart';

part 'pro_view_model.g.dart';

/// Loads the store product; `null` means the store or product is unavailable.
@riverpod
class ProViewModel extends _$ProViewModel {
  @override
  Future<ProductDetails?> build() =>
      ref.watch(purchaseServiceProvider).loadProduct();

  Future<void> buy() async {
    final product = state.value;
    if (product != null) await ref.read(purchaseServiceProvider).buy(product);
  }

  Future<void> restore() => ref.read(purchaseServiceProvider).restore();
}
