import 'package:qitai/features/client/categories/data/datasources/category_remote_data_source.dart';
import 'package:qitai/features/client/categories/domain/entities/category.dart';
import 'package:qitai/features/client/categories/domain/entities/category_tree.dart';
import 'package:qitai/features/client/categories/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource dataSource;

  CategoryRepositoryImpl(this.dataSource);

  @override
  Future<List<Category>> getCategories() async {
    final categoryModel = await dataSource.getCategories();

    return categoryModel
        .map((model) => model.toEntity())
        .toList();
  }

  @override
  Future<List<CategoryTree>> getCategoryTree() async {
    final categoryTreeModel = await dataSource.getCategoryTree();

    return categoryTreeModel
        .map((model) => model.toEntity())
        .toList();
  }
}