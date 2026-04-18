import 'package:qitai/features/client/categories/data/model/cateogry_model.dart' ;

class SearchProductModel {
  final int id;
  final int categoryId;
  final String name;
  final String sku;
  final String partNumber;
  final String condition;
  final String quality;
  final String price;
  final int stock;
  final int isActive;
  final String description;
final CategoryModel? category;
  const SearchProductModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.sku,
    required this.partNumber,
    required this.condition,
    required this.quality,
    required this.price,
    required this.stock,
    required this.isActive,
    required this.description,
    required this.category,
  });

  factory SearchProductModel.fromJson(Map<String, dynamic> json) {
    return SearchProductModel(
      id: json['id'] as int,
      categoryId: json['category_id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      sku: json['sku'] as String? ?? '',
      partNumber: json['part_number'] as String? ?? '',
      condition: json['condition'] as String? ?? '',
      quality: json['quality'] as String? ?? '',
      price: json['price'] as String? ?? '',
      stock: json['stock'] as int? ?? 0,
      isActive: json['is_active'] as int? ?? 0,
      description: json['description'] as String? ?? '',
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'] as Map<String, dynamic>)
          : null,
    );
  }
}
