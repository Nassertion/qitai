import 'package:qitai/core/network/dio_provider.dart';
import 'package:qitai/features/client/categories/data/repository/category_repository.dart';
import 'package:qitai/features/client/categories/data/model/category_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_provider.g.dart';

@riverpod
CategoryRepository categoryRepository(Ref ref) {
  final dio = ref.read(dioProvider);
  return CategoryRepository(dio);
}

@riverpod
Future<List<CategoryModel>> categories(Ref ref) {
  final repo = ref.read(categoryRepositoryProvider);
  return repo.fetchCategories();
}
