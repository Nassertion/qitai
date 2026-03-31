import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qitai/core/dio_provider.dart';
import 'package:qitai/features/client/categories/data/repository/category_repository.dart';
import 'package:qitai/features/client/categories/data/model/cateogry_model.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  final dio = ref.read(dioProvider);
  return CategoryRepository(dio);
});

final categoriesProvider = FutureProvider<List<CategoryModel>>((ref) async {
  await Future.delayed(Duration(seconds: 5));
  final repo = ref.read(categoryRepositoryProvider);
  return repo.fetchCategories();
});
