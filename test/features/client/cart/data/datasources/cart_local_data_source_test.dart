
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

import 'package:qitai/features/client/cart/data/datasources/cart_local_data_source.dart';
import 'package:qitai/features/client/cart/domain/entities/local_cart_item.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferencesAsync preferences;
  late CartLocalDataSource dataSource;

  const storageKey = 'guest_cart';

  const battery = LocalCartItem(
    productId: 5,
    quantity: 2,
    name: 'بطارية 70 أمبير',
    sku: 'BATTERY-70A-001',
    partNumber: 'BAT-70A',
    quality: 'original',
    unitPrice: 320,
  );

  const filter = LocalCartItem(
    productId: 10,
    quantity: 1,
    name: 'فلتر زيت',
    sku: 'FILTER-001',
    partNumber: 'OF-001',
    quality: 'aftermarket',
    unitPrice: 50,
  );

  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();

    preferences = SharedPreferencesAsync();
    dataSource = CartLocalDataSource(preferences);
  });

  group('CartLocalDataSource', () {
    test('returns empty list when cart does not exist', () async {
      final items = await dataSource.getCart();

      expect(items, isEmpty);
    });

    test('saves and restores cart items', () async {
      await dataSource.saveCart([battery, filter]);

      final newDataSource = CartLocalDataSource(preferences);
      final restored = await newDataSource.getCart();

      expect(restored, hasLength(2));

      expect(restored[0].productId, battery.productId);
      expect(restored[0].quantity, battery.quantity);
      expect(restored[0].unitPrice, battery.unitPrice);

      expect(restored[1].productId, filter.productId);
      expect(restored[1].quantity, filter.quantity);
    });

    test('replaces previous cart when saving new items', () async {
      await dataSource.saveCart([battery, filter]);
      await dataSource.saveCart([filter]);

      final restored = await dataSource.getCart();

      expect(restored, hasLength(1));
      expect(restored.first.productId, filter.productId);
    });

    test('preserves order of consecutive writes', () async {
      final firstWrite = dataSource.saveCart([battery]);
      final secondWrite = dataSource.saveCart([battery, filter]);
      final thirdWrite = dataSource.saveCart([filter]);

      await Future.wait([
        firstWrite,
        secondWrite,
        thirdWrite,
      ]);

      final restored = await dataSource.getCart();

      expect(restored, hasLength(1));
      expect(restored.first.productId, filter.productId);
    });

    test('throws FormatException for corrupted JSON', () async {
      await preferences.setString(storageKey, '{invalid json');

      await expectLater(
        dataSource.getCart(),
        throwsFormatException,
      );

      final stored = await preferences.getString(storageKey);

      expect(stored, '{invalid json');
    });

    test('rejects JSON that is not a list', () async {
      await preferences.setString(
        storageKey,
        jsonEncode({'product_id': 5}),
      );

      await expectLater(
        dataSource.getCart(),
        throwsFormatException,
      );
    });

    test('rejects cart containing invalid items', () async {
      await preferences.setString(
        storageKey,
        jsonEncode([
          {
            'product_id': 5,
            'quantity': -2,
            'name': 'بطارية',
            'sku': 'BAT-001',
            'part_number': 'BAT-70A',
            'quality': 'original',
            'unit_price': 320,
            'image_url': null,
          },
        ]),
      );

      await expectLater(
        dataSource.getCart(),
        throwsFormatException,
      );
    });

    test('can save an empty cart', () async {
      await dataSource.saveCart([battery]);
      await dataSource.saveCart([]);

      final restored = await dataSource.getCart();

      expect(restored, isEmpty);
    });
  });
}
