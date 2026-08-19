import 'package:qitai/features/client/categories/data/datasources/category_remote_data_sources.dart';
import 'package:qitai/features/client/categories/data/models/category_model.dart';
import 'package:qitai/features/client/categories/domain/entities/category.dart';
import 'package:qitai/features/client/categories/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource dataSource;
  CategoryRepositoryImpl(this.dataSource);

  @override
  Future<List<Category>> getCategories() async {
    final List<CategoryModel> categoryModel = await dataSource.getCategories();
    final List<Category> category = categoryModel
        .map((model) => model.toEntity())
        .toList();
    return category;
  }
}
