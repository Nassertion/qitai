
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:qitai/features/client/search/domain/entities/search_suggestion.dart';
import 'package:qitai/features/client/search/domain/repositories/search_suggestions_repository.dart';
import 'package:qitai/features/client/search/domain/usecases/get_search_suggestions.dart';
import 'package:qitai/features/client/search/presentation/provider/search_notifier.dart';
import 'package:qitai/features/client/search/presentation/provider/search_suggestions_provider.dart';

// # Fake Search Suggestions Repository
class FakeSearchSuggestionsRepository
    implements SearchSuggestionRepository {
  final requests = <Completer<List<SearchSuggestion>>>[];
  final queries = <String>[];

  @override
  Future<List<SearchSuggestion>> getSuggestions({
    required String query,
  }) {
    queries.add(query);

    final request = Completer<List<SearchSuggestion>>();
    requests.add(request);

    return request.future;
  }
}

void main() {
  // # Old Response Race Condition
  test(
    'Old suggestions response must not overwrite newer response for same query',
    () async {
      // # Arrange
      final repository = FakeSearchSuggestionsRepository();

      final container = ProviderContainer(
        overrides: [
          getSearchSuggestionsProvider.overrideWith(
            (ref) => GetSearchSuggestions(repository),
          ),
        ],
      );

      addTearDown(container.dispose);

      // # Keep Provider Alive
      final subscription = container.listen(
        searchProvider,
        (_, _) {},
      );

      addTearDown(subscription.close);

      final notifier = container.read(
        searchProvider.notifier,
      );

      // # Set Search Query
      notifier.onQueryChanged('TOYOTA');

      // # Start Request A
      final requestA = notifier.loadSuggestions('TOYOTA');

      // # Start Request B
      final requestB = notifier.loadSuggestions('TOYOTA');

      expect(repository.requests.length, 2);
      expect(repository.queries, ['TOYOTA', 'TOYOTA']);

      // # Complete Newer Request First
      final newerSuggestions = <SearchSuggestion>[];

      repository.requests[1].complete(newerSuggestions);

      await requestB;

      expect(
        identical(
          container.read(searchProvider).suggestions,
          newerSuggestions,
        ),
        isTrue,
        reason: 'Newer suggestions should be displayed.',
      );

      // # Complete Older Request Last
      final olderSuggestions = <SearchSuggestion>[];

      repository.requests[0].complete(olderSuggestions);

      await requestA;

      // # Assert Latest Response Wins
      final state = container.read(searchProvider);

      expect(
        identical(state.suggestions, newerSuggestions),
        isTrue,
        reason:
            'An older response for the same query must not replace '
            'the latest suggestions.',
      );

      expect(state.isSuggestionsLoading, false);
    },
  );
}
