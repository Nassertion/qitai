import 'package:qitai/core/network/dio_provider.dart';
import 'package:qitai/features/client/categories/data/datasources/category_remote_data_sourcs.dart';
import 'package:qitai/features/client/categories/data/repositories/category_repository_impl.dart';
import 'package:qitai/features/client/categories/domain/entities/category.dart';
import 'package:qitai/features/client/categories/domain/repositories/category_repository.dart';
import 'package:qitai/features/client/categories/domain/usecases/get_categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_provider.g.dart';

@riverpod
CategoryRemoteDataSource categoryRemoteDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);

  return CategoryRemoteDataSource(dio);
}

@riverpod
CategoryRepository categoryRepository(Ref ref) {
  final dataSource = ref.watch(categoryRemoteDataSourceProvider);

  return CategoryRepositoryImpl(dataSource);
}

@riverpod
GetCategories getCategories(Ref ref) {
  final categoryRepo = ref.watch(categoryRepositoryProvider);
  return GetCategories(categoryRepo);
}
@riverpod
Future<List<Category>> categories(Ref ref) {
  final getCategories = ref.watch(getCategoriesProvider);
  return getCategories();
}