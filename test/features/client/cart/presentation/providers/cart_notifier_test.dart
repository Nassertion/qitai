
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

import 'package:qitai/features/client/cart/data/datasources/cart_local_data_source.dart';
import 'package:qitai/features/client/cart/domain/entities/local_cart_item.dart';
import 'package:qitai/features/client/cart/presentation/providers/cart_notifier.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferencesAsync preferences;
  late CartLocalDataSource dataSource;
  late ProviderContainer container;

  const battery = LocalCartItem(
    productId: 5,
    quantity: 1,
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

    container = ProviderContainer(
      overrides: [
        cartLocalDataSourceProvider.overrideWithValue(dataSource),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('CartNotifier', () {
    test('loads previously saved cart', () async {
      await dataSource.saveCart([battery, filter]);

      final items = await container.read(cartProvider.future);

      expect(items, hasLength(2));
      expect(items[0].productId, 5);
      expect(items[1].productId, 10);
    });

    test('adds a new product', () async {
      await container.read(cartProvider.future);

      await container.read(cartProvider.notifier).addItem(battery);

      final items = await container.read(cartProvider.future);

      expect(items, hasLength(1));
      expect(items.first.productId, 5);
      expect(items.first.quantity, 1);

      final stored = await dataSource.getCart();

      expect(stored, hasLength(1));
      expect(stored.first.productId, 5);
    });

    test('merges quantities when adding same product', () async {
      await container.read(cartProvider.future);

      final notifier = container.read(cartProvider.notifier);

      await notifier.addItem(battery);
      await notifier.addItem(battery);

      final items = await container.read(cartProvider.future);

      expect(items, hasLength(1));
      expect(items.first.quantity, 2);
    });

    test('updates product quantity', () async {
      await container.read(cartProvider.future);

      final notifier = container.read(cartProvider.notifier);

      await notifier.addItem(battery);
      await notifier.updateQuantity(5, 4);

      final items = await container.read(cartProvider.future);

      expect(items.first.quantity, 4);

      final stored = await dataSource.getCart();

      expect(stored.first.quantity, 4);
    });

    test('removes a product without affecting others', () async {
      await container.read(cartProvider.future);

      final notifier = container.read(cartProvider.notifier);

      await notifier.addItem(battery);
      await notifier.addItem(filter);
      await notifier.removeItem(5);

      final items = await container.read(cartProvider.future);

      expect(items, hasLength(1));
      expect(items.first.productId, 10);

      final stored = await dataSource.getCart();

      expect(stored, hasLength(1));
      expect(stored.first.productId, 10);
    });

    test('preserves quantities during concurrent additions', () async {
      await container.read(cartProvider.future);

      final notifier = container.read(cartProvider.notifier);

      await Future.wait([
        notifier.addItem(battery),
        notifier.addItem(battery),
        notifier.addItem(battery),
        notifier.addItem(battery),
        notifier.addItem(battery),
      ]);

      final items = await container.read(cartProvider.future);

      expect(items, hasLength(1));
      expect(items.first.quantity, 5);

      final stored = await dataSource.getCart();

      expect(stored, hasLength(1));
      expect(stored.first.quantity, 5);
    });
  });
}
