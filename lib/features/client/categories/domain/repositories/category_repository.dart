import 'package:qitai/features/client/categories/domain/entities/category.dart';
import 'package:qitai/features/client/categories/domain/entities/category_tree.dart';

abstract interface class CategoryRepository {
  Future<List<Category>> getCategories();
    Future<List<CategoryTree>> getCategoryTree();

}
