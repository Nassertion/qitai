import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:qitai/features/client/search/domain/entities/search_suggestion.dart';
import 'package:qitai/features/client/search/domain/repositories/search_suggestions_repository.dart';
import 'package:qitai/features/client/search/domain/usecases/get_search_suggestions.dart';

class MockSearchSuggestionRepository extends Mock
    implements SearchSuggestionRepository {}

void main() {
  late MockSearchSuggestionRepository repository;
  late GetSearchSuggestions getSearchSuggestions;

  setUp(() {
    repository = MockSearchSuggestionRepository();
    getSearchSuggestions = GetSearchSuggestions(repository);
  });

  test('should return search suggestions from repository', () async {
    // Arrange
    const query = 'كامري';
    const suggestions = <SearchSuggestion>[];

    when(
      () => repository.getSuggestions(query: query),
    ).thenAnswer((_) async => suggestions);

    // Act
    final result = await getSearchSuggestions(query: query);

    // Assert
    expect(result, suggestions);

    verify(
      () => repository.getSuggestions(query: query),
    ).called(1);
  });
}