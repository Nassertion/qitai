import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:qitai/features/client/categories/domain/entities/category.dart';
import 'package:qitai/features/client/categories/domain/repositories/category_repository.dart';
import 'package:qitai/features/client/categories/domain/usecases/get_categories.dart';

class MockCategoryRepository extends Mock implements CategoryRepository {}

void main() {
  late MockCategoryRepository repository;
  late GetCategories getCategories;

  setUp(() {
    repository = MockCategoryRepository();
    getCategories = GetCategories(repository);
  });

  test('should return categories from repository', () async {
    // Arrange
    const categories = <Category>[];

    when(
      () => repository.getCategories(),
    ).thenAnswer((_) async => categories);

    // Act
    final result = await getCategories();

    // Assert
    expect(result, categories);

    verify(
      () => repository.getCategories(),
    ).called(1);
  });
}