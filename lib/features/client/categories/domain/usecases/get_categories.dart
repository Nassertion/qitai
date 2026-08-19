import 'package:qitai/features/client/categories/domain/entities/category.dart';
import 'package:qitai/features/client/categories/domain/repositories/category_repository.dart';

class GetCategories {

  final CategoryRepository repo;
  GetCategories(this.repo);

  Future<List<Category>> call() {
    return repo.getCategories();
  }
}