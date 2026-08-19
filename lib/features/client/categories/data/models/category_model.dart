import 'package:qitai/features/client/categories/domain/entities/category.dart';

class CategoryModel {
  final int id;
  final String name;
  final String? iconPath;
  final String? iconUrl;
  final int? parentId;
  final int sortOrder;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    this.iconPath,
    this.iconUrl,
    this.parentId,
    required this.sortOrder,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      iconPath: json['icon_path'] as String?,
      iconUrl: json['icon_url'] as String?,
      parentId: json['parent_id'] as int?,
      sortOrder: json['sort_order'] as int,
      isActive: (json['is_active'] as int?) == 1,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,

      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon_path': iconPath,
      'icon_url': iconUrl,
      'parent_id': parentId,
      'sort_order': sortOrder,
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  Category toEntity() {
    return Category(
      id: id,
      name: name,
      sortOrder: sortOrder,
      isActive: isActive,
      iconPath: iconPath,
      iconUrl: iconUrl,
      parentId: parentId,
    );
  }
}
