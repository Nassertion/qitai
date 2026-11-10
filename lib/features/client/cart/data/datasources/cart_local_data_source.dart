import 'dart:convert';

import 'package:qitai/features/client/cart/domain/entities/local_cart_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qitai/features/client/cart/data/mappers/local_cart_item_mapper.dart';

class CartLocalDataSource {
  static const _storageKey = 'guest_cart';

  final SharedPreferencesAsync preferences;

  Future<void> _pendingWrites = Future.value();

  CartLocalDataSource(this.preferences);

  Future<List<LocalCartItem>> getCart() async {
    await _pendingWrites;

    final stored = await preferences.getString(_storageKey);

    if (stored == null) {
      return [];
    }

    try {
      final decoded = jsonDecode(stored);

      if (decoded is! List) {
        throw const FormatException('Invalid cart format');
      }

      return decoded.map((item) {
        if (item is! Map<String, dynamic>) {
          throw const FormatException('Invalid cart item format');
        }

        return LocalCartItemMapper.fromJson(item);
      }).toList();
    } on FormatException {
      rethrow;
    } on TypeError catch (error) {
      throw FormatException('Invalid cart data: $error');
    }
  }

  Future<void> saveCart(List<LocalCartItem> items) {
    final encoded = jsonEncode(items.map(LocalCartItemMapper.toJson).toList());

    _pendingWrites = _pendingWrites
        .catchError((Object _) {
          // Allow a new write after a previous write failed.
        })
        .then((_) => preferences.setString(_storageKey, encoded));

    return _pendingWrites;
  }
}
