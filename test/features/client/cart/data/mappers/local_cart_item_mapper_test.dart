import 'package:flutter_test/flutter_test.dart';
import 'package:qitai/features/client/cart/data/mappers/local_cart_item_mapper.dart';
import 'package:qitai/features/client/cart/domain/entities/local_cart_item.dart';

void main() {
  group('LocalCartItemMapper', () {
    const item = LocalCartItem(
      productId: 5,
      quantity: 2,
      name: 'بطارية 70 أمبير',
      sku: 'BATTERY-70A-001',
      partNumber: 'BAT-70A',
      quality: 'original',
      unitPrice: 320,
      imageUrl: 'https://example.com/battery.png',
    );

    test('converts entity to JSON correctly', () {
      final json = LocalCartItemMapper.toJson(item);

      expect(json, {
        'product_id': 5,
        'quantity': 2,
        'name': 'بطارية 70 أمبير',
        'sku': 'BATTERY-70A-001',
        'part_number': 'BAT-70A',
        'quality': 'original',
        'unit_price': 320,
        'image_url': 'https://example.com/battery.png',
      });
    });

    test('restores entity from JSON correctly', () {
      final json = LocalCartItemMapper.toJson(item);

      final restored = LocalCartItemMapper.fromJson(json);

      expect(restored.productId, item.productId);
      expect(restored.quantity, item.quantity);
      expect(restored.name, item.name);
      expect(restored.sku, item.sku);
      expect(restored.partNumber, item.partNumber);
      expect(restored.quality, item.quality);
      expect(restored.unitPrice, item.unitPrice);
      expect(restored.imageUrl, item.imageUrl);
    });

    test('supports products without images', () {
      final json = LocalCartItemMapper.toJson(
        const LocalCartItem(
          productId: 10,
          quantity: 1,
          name: 'فلتر زيت',
          sku: 'FILTER-001',
          partNumber: 'OF-001',
          quality: 'original',
          unitPrice: 50,
        ),
      );

      final restored = LocalCartItemMapper.fromJson(json);

      expect(restored.imageUrl, isNull);
    });

    test('rejects invalid quantity', () {
      final json = LocalCartItemMapper.toJson(item);
      json['quantity'] = -1;

      expect(() => LocalCartItemMapper.fromJson(json), throwsFormatException);
    });

    test('rejects invalid product ID', () {
      final json = LocalCartItemMapper.toJson(item);
      json['product_id'] = 0;

      expect(() => LocalCartItemMapper.fromJson(json), throwsFormatException);
    });

    test('rejects invalid field types', () {
      final json = LocalCartItemMapper.toJson(item);
      json['unit_price'] = '320';

      expect(() => LocalCartItemMapper.fromJson(json), throwsFormatException);
    });

    test('rejects missing required fields', () {
      final json = LocalCartItemMapper.toJson(item);
      json.remove('name');

      expect(() => LocalCartItemMapper.fromJson(json), throwsFormatException);
    });
  });
}
