
import 'package:qitai/features/client/cart/data/datasources/cart_local_data_source.dart';
import 'package:qitai/features/client/cart/domain/entities/local_cart_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'cart_notifier.g.dart';

@Riverpod(keepAlive: true)
CartLocalDataSource cartLocalDataSource(Ref ref) {
  return CartLocalDataSource(SharedPreferencesAsync());
}

@Riverpod(keepAlive: true)
class CartNotifier extends _$CartNotifier {
  Future<void> _pendingMutation = Future.value();

  @override
  Future<List<LocalCartItem>> build() {
    return ref.read(cartLocalDataSourceProvider).getCart();
  }

  Future<void> _mutate(
    List<LocalCartItem> Function(List<LocalCartItem>) update,
  ) {
    final operation = _pendingMutation.then((_) async {
      final currentItems = await future;

      if (!ref.mounted) return;

      final updatedItems = update(currentItems);

      await ref
          .read(cartLocalDataSourceProvider)
          .saveCart(updatedItems);

      if (!ref.mounted) return;

      state = AsyncData(updatedItems);
    });

    _pendingMutation = operation.catchError((Object _) {
      // Keep the queue usable after a failed operation.
    });

    return operation;
  }

  Future<void> addItem(LocalCartItem item) {
    if (item.quantity <= 0) {
      throw ArgumentError.value(
        item.quantity,
        'quantity',
        'Quantity must be greater than zero',
      );
    }

    return _mutate((items) {
      final index = items.indexWhere(
        (existing) => existing.productId == item.productId,
      );

      if (index == -1) {
        return [...items, item];
      }

      final existing = items[index];

      final updatedItem = _withQuantity(
        item,
        existing.quantity + item.quantity,
      );

      return [
        for (final current in items)
          if (current.productId == item.productId)
            updatedItem
          else
            current,
      ];
    });
  }

  Future<void> updateQuantity(int productId, int quantity) {
    if (quantity <= 0) {
      throw ArgumentError.value(
        quantity,
        'quantity',
        'Quantity must be greater than zero',
      );
    }

    return _mutate((items) {
      return [
        for (final item in items)
          if (item.productId == productId)
            _withQuantity(item, quantity)
          else
            item,
      ];
    });
  }

  Future<void> removeItem(int productId) {
    return _mutate((items) {
      return items
          .where((item) => item.productId != productId)
          .toList();
    });
  }

  LocalCartItem _withQuantity(
    LocalCartItem item,
    int quantity,
  ) {
    return LocalCartItem(
      productId: item.productId,
      quantity: quantity,
      name: item.name,
      sku: item.sku,
      partNumber: item.partNumber,
      quality: item.quality,
      unitPrice: item.unitPrice,
      imageUrl: item.imageUrl,
    );
  }
}
