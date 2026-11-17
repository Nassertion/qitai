
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:qitai/features/client/cart/domain/entities/local_cart_item.dart';
import 'package:qitai/features/client/cart/presentation/widgets/cart_item_widget.dart';

void main() {
  const battery = LocalCartItem(
    productId: 5,
    quantity: 2,
    name: 'بطارية 70 أمبير',
    sku: 'BATTERY-70A-001',
    partNumber: 'BAT-70A',
    quality: 'original',
    unitPrice: 320,
  );

  Future<void> pumpCartItem(
    WidgetTester tester, {
    LocalCartItem item = battery,
    VoidCallback? onIncrement,
    VoidCallback? onDecrement,
    Future<void> Function()? onDelete,
    bool isUpdating = false,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: CartItemWidget(
              item: item,
              onIncrement: onIncrement ?? () {},
              onDecrement: onDecrement ?? () {},
              onDelete: onDelete ?? () async {},
              isUpdating: isUpdating,
            ),
          ),
        ),
      ),
    );
  }

  group('CartItemWidget', () {
    testWidgets('displays product information correctly', (
      tester,
    ) async {
      await pumpCartItem(tester);

      expect(find.text(battery.name), findsOneWidget);
      expect(
        find.text('رقم القطعة: ${battery.partNumber}'),
        findsOneWidget,
      );
      expect(find.text('320'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('calls increment callback', (tester) async {
      var incrementCount = 0;

      await pumpCartItem(
        tester,
        onIncrement: () => incrementCount++,
      );

      await tester.tap(find.byIcon(Icons.add));

      expect(incrementCount, 1);
    });

    testWidgets('calls decrement callback', (tester) async {
      var decrementCount = 0;

      await pumpCartItem(
        tester,
        onDecrement: () => decrementCount++,
      );

      await tester.tap(find.byIcon(Icons.remove));

      expect(decrementCount, 1);
    });

    testWidgets('disables decrement when quantity is one', (
      tester,
    ) async {
      var decrementCount = 0;

      const singleItem = LocalCartItem(
        productId: 5,
        quantity: 1,
        name: 'بطارية 70 أمبير',
        sku: 'BATTERY-70A-001',
        partNumber: 'BAT-70A',
        quality: 'original',
        unitPrice: 320,
      );

      await pumpCartItem(
        tester,
        item: singleItem,
        onDecrement: () => decrementCount++,
      );

      await tester.tap(find.byIcon(Icons.remove));

      expect(decrementCount, 0);
    });

    testWidgets('disables quantity buttons while updating', (
      tester,
    ) async {
      var incrementCount = 0;
      var decrementCount = 0;

      await pumpCartItem(
        tester,
        isUpdating: true,
        onIncrement: () => incrementCount++,
        onDecrement: () => decrementCount++,
      );

      await tester.tap(find.byIcon(Icons.add));
      await tester.tap(find.byIcon(Icons.remove));

      expect(incrementCount, 0);
      expect(decrementCount, 0);
    });

    testWidgets('reveals delete action when swiping right', (
      tester,
    ) async {
      var deleteCount = 0;

      await pumpCartItem(
        tester,
        onDelete: () async => deleteCount++,
      );

      await tester.drag(
        find.byType(CartItemWidget),
        const Offset(90, 0),
      );

      await tester.pumpAndSettle();

      final deleteAction = find.byKey(
        const ValueKey('cart-confirm-delete'),
      );

      expect(deleteAction, findsOneWidget);

      final deleteButton = tester.widget<InkWell>(
        deleteAction,
      );

      expect(deleteButton.onTap, isNotNull);

      // Swiping should only reveal the action.
      expect(deleteCount, 0);
    });

    testWidgets('calls delete callback after tapping action', (
      tester,
    ) async {
      var deleteCount = 0;

      await pumpCartItem(
        tester,
        onDelete: () async {
          deleteCount++;
        },
      );

      await tester.drag(
        find.byType(CartItemWidget),
        const Offset(90, 0),
      );

      await tester.pumpAndSettle();

      await tester.tap(
        find.byKey(
          const ValueKey('cart-confirm-delete'),
        ),
      );

      await tester.pumpAndSettle();

      expect(deleteCount, 1);
    });

    testWidgets('closes delete action when swiping left', (
      tester,
    ) async {
      await pumpCartItem(tester);

      final itemFinder = find.byType(CartItemWidget);

      await tester.drag(
        itemFinder,
        const Offset(90, 0),
      );

      await tester.pumpAndSettle();

      await tester.drag(
        itemFinder,
        const Offset(-90, 0),
      );

      await tester.pumpAndSettle();

      final deleteAction = find.byKey(
        const ValueKey('cart-confirm-delete'),
      );

      final actionButton = tester.widget<InkWell>(
        deleteAction,
      );

      expect(actionButton.onTap, isNotNull);

      final itemPosition = tester.getTopLeft(
        find.byType(CartItemWidget),
      );

      // Content returns to its original position.
      final content = find.text(battery.name);

      expect(
        tester.getTopLeft(content).dx,
        greaterThan(itemPosition.dx),
      );
    });
  });
}
