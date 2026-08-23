import 'package:qitai/features/client/products/domain/entities/product_image.dart';

class ProductImageModel {
  final int id;
  final String url;
  final bool isPrimary;
  final int sortOrder;

  const ProductImageModel({
    required this.id,
    required this.url,
    required this.isPrimary,
    required this.sortOrder,
  });

  factory ProductImageModel.fromJson(Map<String, dynamic> json) {
    return ProductImageModel(
      id: json['id'] as int,
      url: json['url'] as String? ?? '',
      isPrimary: json['is_primary'] as bool? ?? false,
      sortOrder: json['sort_order'] as int? ?? 0,
    );
  }
  ProductImage toEntity() {
    return ProductImage(
      id: id,
      url: url,
      isPrimary: isPrimary,
      sortOrder: sortOrder,
    );
  }
}
