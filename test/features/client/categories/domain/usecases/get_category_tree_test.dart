import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:qitai/features/client/categories/domain/entities/category_tree.dart';
import 'package:qitai/features/client/categories/domain/repositories/category_repository.dart';
import 'package:qitai/features/client/categories/domain/usecases/get_category_tree.dart';

class MockCategoryRepository extends Mock implements CategoryRepository {}

void main() {
  late MockCategoryRepository repository;
  late GetCategoryTree getCategoryTree;

  setUp(() {
    repository = MockCategoryRepository();
    getCategoryTree = GetCategoryTree(repository);
  });

  test('should return category tree from repository', () async {
    // Arrange
    const categoryTree = <CategoryTree>[];

    when(
      () => repository.getCategoryTree(),
    ).thenAnswer((_) async => categoryTree);

    // Act
    final result = await getCategoryTree();

    // Assert
    expect(result, categoryTree);

    verify(
      () => repository.getCategoryTree(),
    ).called(1);
  });
}