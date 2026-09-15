import 'package:qitai/features/client/categories/domain/entities/category_tree.dart';
import 'package:qitai/features/client/categories/domain/repositories/category_repository.dart';

class GetCategoryTree {
  final CategoryRepository repo;

  GetCategoryTree(this.repo);

  Future<List<CategoryTree>> call() {
    return repo.getCategoryTree();
  }
}