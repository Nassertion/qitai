import 'package:qitai/features/client/products/data/models/product_image_model.dart';
import 'package:qitai/features/client/products/domain/entities/product_detail.dart';

class ProductDetailModel {
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
  final ProductDetailCategoryModel? category;
  final List<ProductImageModel> images;
  final List<ProductCompatibilityModel> compatibilities;

  const ProductDetailModel({
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

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      sku: json['sku'] as String? ?? '',
      partNumber: json['part_number'] as String? ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
      stock: ((json['stock'] as int?) ?? 0),
      stockStatus: json['stock_status'] as String? ?? '',
      condition: json['condition'] as String? ?? '',
      quality: json['quality'] as String? ?? '',
      description: json['description'] as String? ?? '',
      category: json['category'] != null
          ? ProductDetailCategoryModel.fromJson(
              json['category'] as Map<String, dynamic>,
            )
          : null,
      images: (json['images'] as List<dynamic>? ?? [])
          .map(
            (item) => ProductImageModel.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
      compatibilities: (json['compatibilities'] as List<dynamic>? ?? [])
          .map(
            (item) => ProductCompatibilityModel.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }
  ProductDetail toEntity() {
    return ProductDetail(
      id: id,
      name: name,
      sku: sku,
      partNumber: partNumber,
      price: price,
      stock: stock,
      stockStatus: stockStatus,
      condition: condition,
      quality: quality,
      description: description,
      category: category?.toEntity(),
      images: images.map((image) => image.toEntity()).toList(),
        compatibilities: compatibilities
          .map((compatibility) => compatibility.toEntity())
          .toList(),
    );
  }
}

class ProductDetailCategoryModel {
  final int id;
  final String name;
  final String? icon;

  const ProductDetailCategoryModel({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory ProductDetailCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailCategoryModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      icon: json['icon'] as String?,
    );
  }
  ProductDetailCategory toEntity() {
    return ProductDetailCategory(id: id, name: name, icon: icon);
  }
}

class ProductCompatibilityModel {
  final int id;
  final String matchType;
  final int? modelId;
  final String? vin;
  final String? modelName;
  final int? yearFrom;
  final int? yearTo;

  const ProductCompatibilityModel({
    required this.id,
    required this.matchType,
    required this.modelId,
    required this.vin,
    required this.modelName,
    required this.yearFrom,
    required this.yearTo,
  });

  factory ProductCompatibilityModel.fromJson(Map<String, dynamic> json) {
    return ProductCompatibilityModel(
      id: json['id'] as int,
      matchType: json['match_type'] as String? ?? '',
      modelId: json['model_id'] as int?,
      vin: json['vin'] as String?,
      modelName: json['model_name'] as String?,
      yearFrom: json['year_from'] as int?,
      yearTo: json['year_to'] as int?,
    );
  }
  ProductCompatibility toEntity() {
    return ProductCompatibility(
      id: id,
      matchType: matchType,
      modelId: modelId,
      vin: vin,
      modelName: modelName,
      yearFrom: yearFrom,
      yearTo: yearTo,
    );
  }
}
