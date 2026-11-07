
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:qitai/features/client/search/presentation/provider/search_notifier.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_notifier.dart';

void main() {
  test(
    'SearchNotifier rebuilds without LateInitializationError',
    () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final subscription = container.listen(
        searchProvider,
        (_, _) {},
      );
      addTearDown(subscription.close);

      // Initialize the notifier.
      expect(
        container.read(searchProvider).hasSearched,
        false,
      );

      // Force provider invalidation and rebuilding.
      container.invalidate(searchProvider);

      expect(
        () => container.read(searchProvider),
        returnsNormally,
      );
    },
  );

  test(
    'VehicleNotifier rebuilds without LateInitializationError',
    () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final subscription = container.listen(
        vehicleProvider,
        (_, _) {},
      );
      addTearDown(subscription.close);

      // Initialize the notifier.
      expect(
        container.read(vehicleProvider).carBrands,
        isEmpty,
      );

      // Force provider invalidation and rebuilding.
      container.invalidate(vehicleProvider);

      expect(
        () => container.read(vehicleProvider),
        returnsNormally,
      );
    },
  );
}
