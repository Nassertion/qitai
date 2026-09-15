import 'package:qitai/features/client/categories/data/models/category_model.dart';
import 'package:qitai/features/client/categories/domain/entities/category_tree.dart';

class CategoryTreeModel {
  final CategoryModel category;
  final List<CategoryModel> children;

  const CategoryTreeModel({
    required this.category,
    required this.children,
  });

  factory CategoryTreeModel.fromJson(Map<String, dynamic> json) {
    final childrenData = json['children'] as List<dynamic>? ?? [];

    return CategoryTreeModel(
      category: CategoryModel.fromJson(json),
      children: childrenData
          .map(
            (item) => CategoryModel.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }

  CategoryTree toEntity() {
    return CategoryTree(
      category: category.toEntity(),
      children: children
          .map((child) => child.toEntity())
          .toList(),
    );
  }
}