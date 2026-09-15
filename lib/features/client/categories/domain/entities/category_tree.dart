import 'package:qitai/features/client/categories/domain/entities/category.dart';

class CategoryTree {
  final Category category;
  final List<Category> children;

  const CategoryTree({
    required this.category,
    this.children = const [],
  });
}