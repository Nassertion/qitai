import 'package:qitai/features/client/cart/domain/entities/local_cart_item.dart';

class LocalCartItemMapper {
  const LocalCartItemMapper._();

  static Map<String, dynamic> toJson(LocalCartItem item) {
    return {
      'product_id': item.productId,
      'quantity': item.quantity,
      'name': item.name,
      'sku': item.sku,
      'part_number': item.partNumber,
      'quality': item.quality,
      'unit_price': item.unitPrice,
      'image_url': item.imageUrl,
    };
  }

  static LocalCartItem fromJson(Map<String, dynamic> json) {
    final productId = json['product_id'];
    final quantity = json['quantity'];
    final name = json['name'];
    final sku = json['sku'];
    final partNumber = json['part_number'];
    final quality = json['quality'];
    final unitPrice = json['unit_price'];
    final imageUrl = json['image_url'];

    if (productId is! int ||
        productId <= 0 ||
        quantity is! int ||
        quantity <= 0 ||
        name is! String ||
        sku is! String ||
        partNumber is! String ||
        quality is! String ||
        unitPrice is! int ||
        unitPrice < 0 ||
        (imageUrl != null && imageUrl is! String)) {
      throw const FormatException('Invalid local cart item');
    }

    return LocalCartItem(
      productId: productId,
      quantity: quantity,
      name: name,
      sku: sku,
      partNumber: partNumber,
      quality: quality,
      unitPrice: unitPrice,
      imageUrl: imageUrl,
    );
  }
}
