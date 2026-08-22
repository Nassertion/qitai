class ProductImage {
  final int id;
  final String url;
  final bool isPrimary;
  final int sortOrder;

  const ProductImage({
    required this.id,
    required this.url,
    required this.isPrimary,
    required this.sortOrder,
  });
}