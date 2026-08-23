import 'package:qitai/features/client/products/data/models/product_image_model.dart';
import 'package:qitai/features/client/products/domain/entities/product.dart';

class ProductModel {
  final int id;
  final String name;
  final String sku;
  final String partNumber;
  final String condition;
  final String quality;
  final int price;
  final int stock;
  final bool inStock;
  final String description;
  final ProductCategoryModel? category;
  final List<ProductImageModel> images;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProductModel({
    required this.id,
    required this.name,
    required this.sku,
    required this.partNumber,
    required this.condition,
    required this.quality,
    required this.price,
    required this.stock,
    required this.inStock,
    required this.description,
    required this.category,
    required this.images,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      sku: json['sku'] as String? ?? '',
      partNumber: json['part_number'] as String? ?? '',
      condition: json['condition'] as String? ?? '',
      quality: json['quality'] as String? ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
      stock: json['stock'] as int? ?? 0,
      inStock: json['in_stock'] as bool,
      description: json['description'] as String? ?? '',
      category: json['category'] != null
          ? ProductCategoryModel.fromJson(
              json['category'] as Map<String, dynamic>,
            )
          : null,

      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,

      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      images: (json['images'] as List<dynamic>? ?? [])
          .map(
            (item) => ProductImageModel.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }
  Product toEntity() {
    return Product(
      id: id,
      name: name,
      sku: sku,
      partNumber: partNumber,
      condition: condition,
      quality: quality,
      price: price,
      stock: stock,
      inStock: inStock,
      images: images.map((image) => image.toEntity()).toList(),
      category: category?.toEntity(),
    );
  }
}

class ProductCategoryModel {
  final int id;
  final String name;
  final int? parentId;
  final String? iconUrl;

  const ProductCategoryModel({
    required this.id,
    required this.name,
    this.parentId,
    this.iconUrl,
  });

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductCategoryModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      parentId: json['parent_id'] as int?,
      iconUrl: json['icon_url'] as String?,
    );
  }
  ProductCategory toEntity() {
    return ProductCategory(
      id: id,
      name: name,
      iconUrl: iconUrl,
      parentId: parentId,
    );
  }
}
