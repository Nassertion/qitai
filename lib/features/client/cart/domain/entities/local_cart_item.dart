class LocalCartItem {
  final int productId;
  final int quantity;
  final String name;
  final String sku;
  final String partNumber;
  final String quality;
  final int unitPrice;
  final String? imageUrl;

  const LocalCartItem({
    required this.productId,
    required this.quantity,
    required this.name,
    required this.sku,
    required this.partNumber,
    required this.quality,
    required this.unitPrice,
    this.imageUrl,
  });
}
