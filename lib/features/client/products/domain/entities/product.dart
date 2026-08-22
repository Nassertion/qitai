import 'package:qitai/features/client/products/domain/entities/product_image.dart';

class Product {
  final int id;
  final String name;
  final String sku;
  final String partNumber;
  final String condition;
  final String quality;
  final int price;
  final int stock;
  final bool inStock;
  final List<ProductImage> images;
  final ProductCategory? category;
  const Product({
    required this.id,
    required this.name,
    required this.sku,
    required this.partNumber,
    required this.condition,
    required this.quality,
    required this.price,
    required this.stock,
    required this.inStock,
    required this.images,
    required this.category,
  });
}

class ProductCategory {
  final int id;
  final String name;
  final int? parentId;
  final String? iconUrl;

  const ProductCategory({
    required this.id,
    required this.name,
    this.parentId,
    this.iconUrl,
  });
}
