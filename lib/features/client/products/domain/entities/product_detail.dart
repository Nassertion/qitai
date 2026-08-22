import 'package:qitai/features/client/products/domain/entities/product_image.dart';

class ProductDetail {
  final int id;
  final String name;
  final String sku;
  final String partNumber;
  final int price;
  final int stock;
  final String stockStatus;
  final String condition;
  final String quality;
  final String description;
  final ProductCategory? category;
  final List<ProductImage> images;
  final List<ProductCompatibility> compatibilities;

  const ProductDetail({
    required this.id,
    required this.name,
    required this.sku,
    required this.partNumber,
    required this.price,
    required this.stock,
    required this.stockStatus,
    required this.condition,
    required this.quality,
    required this.description,
    required this.category,
    required this.images,
    required this.compatibilities,
  });
}

class ProductCategory {
  final int id;
  final String name;
  final String? icon;

  const ProductCategory({
    required this.id,
    required this.name,
    required this.icon,
  });
}

class ProductCompatibility {
  final int id;
  final String matchType;
  final int? modelId;
  final String? vin;
  final String? modelName;
  final int? yearFrom;
  final int? yearTo;

  ProductCompatibility({
    required this.id,
    required this.matchType,
    required this.modelId,
    required this.vin,
    required this.modelName,
    required this.yearFrom,
    required this.yearTo,
  });
}

