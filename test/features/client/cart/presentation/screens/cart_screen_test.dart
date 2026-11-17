import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

import 'package:qitai/features/client/cart/data/datasources/cart_local_data_source.dart';
import 'package:qitai/features/client/cart/domain/entities/local_cart_item.dart';
import 'package:qitai/features/client/cart/presentation/providers/cart_notifier.dart';
import 'package:qitai/features/client/cart/presentation/screens/cart_screen.dart';
import 'package:qitai/features/client/cart/presentation/widgets/cart_item_widget.dart';

class FakeCartLocalDataSource extends CartLocalDataSource {
  FakeCartLocalDataSource(List<LocalCartItem> initialItems)
    : _items = List.of(initialItems),
      super(SharedPreferencesAsync());

  List<LocalCartItem> _items;

  @override
  Future<List<LocalCartItem>> getCart() async {
    return List.of(_items);
  }

  @override
  Future<void> saveCart(List<LocalCartItem> items) async {
    _items = List.of(items);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    // Every test gets a fresh in-memory preferences platform.
    // SharedPreferencesAsync requires a platform instance
    // even though the fake data source overrides read/write.
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  const firstProduct = LocalCartItem(
    productId: 1,
    quantity: 2,
    name: 'فحمات فرامل أمامية',
    sku: 'BRAKE-001',
    partNumber: '04465-06150',
    quality: 'original',
    unitPrice: 300,
  );

  const secondProduct = LocalCartItem(
    productId: 2,
    quantity: 1,
    name: 'فحمات فرامل خلفية',
    sku: 'BRAKE-002',
    partNumber: '00486-01123',
    quality: 'original',
    unitPrice: 150,
  );

  Future<void> pumpCartScreen(
    WidgetTester tester, {
    List<LocalCartItem>? items,
  }) async {
    final dataSource = FakeCartLocalDataSource(
      items ?? [firstProduct, secondProduct],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [cartLocalDataSourceProvider.overrideWithValue(dataSource)],
        child: const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: CartScreen(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
  }

  Finder productCard(int index) {
    return find.byType(CartItemWidget).at(index);
  }

  Finder quantityButton(int index, IconData icon) {
    return find.descendant(of: productCard(index), matching: find.byIcon(icon));
  }

  Future<void> openDeleteDialog(WidgetTester tester) async {
    final firstCard = productCard(0);

    // Tap the small foreground delete icon
    // to reveal the delete action.
    final smallDeleteIcon = find
        .descendant(of: firstCard, matching: find.byIcon(Icons.delete_outline))
        .last;

    await tester.tap(smallDeleteIcon);
    await tester.pumpAndSettle();

    final deleteAction = find.descendant(
      of: firstCard,
      matching: find.byKey(const ValueKey('cart-confirm-delete')),
    );

    await tester.tap(deleteAction);
    await tester.pumpAndSettle();
  }

  group('CartScreen', () {
    testWidgets('displays cart products and correct subtotal', (tester) async {
      await pumpCartScreen(tester);

      expect(find.text('فحمات فرامل أمامية'), findsOneWidget);

      expect(find.text('فحمات فرامل خلفية'), findsOneWidget);

      expect(find.byType(CartItemWidget), findsNWidgets(2));

      // 300 * 2 + 150 * 1 = 750
      expect(find.text('750'), findsOneWidget);
    });

    testWidgets('updates subtotal after incrementing quantity', (tester) async {
      await pumpCartScreen(tester);

      await tester.tap(quantityButton(0, Icons.add));

      await tester.pumpAndSettle();

      // 300 * 3 + 150 = 1050
      expect(find.text('1050'), findsOneWidget);

      final itemWidget = tester.widget<CartItemWidget>(productCard(0));

      expect(itemWidget.item.quantity, 3);
    });

    testWidgets('updates subtotal after decrementing quantity', (tester) async {
      await pumpCartScreen(tester);

      await tester.tap(quantityButton(0, Icons.remove));

      await tester.pumpAndSettle();

      // 300 * 1 + 150 = 450
      expect(find.text('450'), findsOneWidget);

      final itemWidget = tester.widget<CartItemWidget>(productCard(0));

      expect(itemWidget.item.quantity, 1);
    });

    testWidgets('cancelling deletion keeps product and subtotal', (
      tester,
    ) async {
      await pumpCartScreen(tester);

      await openDeleteDialog(tester);

      expect(find.text('حذف المنتج'), findsOneWidget);

      await tester.tap(find.text('تراجع'));
      await tester.pumpAndSettle();

      expect(find.byType(CartItemWidget), findsNWidgets(2));

      expect(find.text('فحمات فرامل أمامية'), findsOneWidget);

      expect(find.text('750'), findsOneWidget);
    });

    testWidgets('confirming deletion removes item and updates subtotal', (
      tester,
    ) async {
      await pumpCartScreen(tester);

      await openDeleteDialog(tester);

      await tester.tap(find.text('حذف'));
      await tester.pumpAndSettle();

      // Deleted product must disappear.
      expect(find.text('فحمات فرامل أمامية'), findsNothing);

      // Remaining product must still exist.
      expect(find.text('فحمات فرامل خلفية'), findsOneWidget);

      expect(find.byType(CartItemWidget), findsOneWidget);

      // Verify the remaining cart item.
      final remainingItem = tester.widget<CartItemWidget>(
        find.byType(CartItemWidget),
      );

      expect(remainingItem.item.productId, 2);
      expect(remainingItem.item.quantity, 1);
      expect(remainingItem.item.unitPrice, 150);

      // Price and subtotal are both 150.
      expect(find.text('150'), findsNWidgets(2));
    });
  });
}
