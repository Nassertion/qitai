
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:qitai/features/client/vehicles/domain/entities/car_brand.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_notifier.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_state.dart';

// # Fake Notifier
// Uses the real VehicleState without making API requests.
class TestVehicleNotifier extends VehicleNotifier {
  @override
  VehicleState build() => const VehicleState();

  @override
  Future<void> selectBrand(CarBrand brand) async {
    state = state.copyWith(
      selectedCarBrand: brand,
      clearSelectedModel: true,
      clearSelectedCarYear: true,
      models: [],
      carYears: [],
    );
  }
}

// # Represents One Screen With Its Own ProviderScope
class TestVehicleScreen extends StatelessWidget {
  const TestVehicleScreen({
    super.key,
    required this.screenName,
    required this.brand,
  });

  final String screenName;
  final CarBrand brand;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        vehicleProvider.overrideWith(TestVehicleNotifier.new),
      ],
      child: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(vehicleProvider);

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                state.selectedCarBrand?.name ?? 'No brand selected',
                key: Key('$screenName-brand'),
              ),
              ElevatedButton(
                key: Key('$screenName-select'),
                onPressed: () {
                  ref.read(vehicleProvider.notifier).selectBrand(brand);
                },
                child: Text('Select $screenName'),
              ),
            ],
          );
        },
      ),
    );
  }
}

void main() {
  testWidgets(
    'Vehicle filters remain independent between search and add car',
    (tester) async {
      // # Arrange
      const toyota = CarBrand(id: 1, name: 'Toyota');
      const hyundai = CarBrand(id: 2, name: 'Hyundai');

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  TestVehicleScreen(
                    screenName: 'search',
                    brand: toyota,
                  ),
                  TestVehicleScreen(
                    screenName: 'add-car',
                    brand: hyundai,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      // # Both Scopes Start Empty
      expect(
        find.byKey(const Key('search-brand')),
        findsOneWidget,
      );

      expect(
        find.byKey(const Key('add-car-brand')),
        findsOneWidget,
      );

      expect(
        find.text('No brand selected'),
        findsNWidgets(2),
      );

      // # Select Toyota In Search
      await tester.tap(find.byKey(const Key('search-select')));
      await tester.pump();

      expect(
        tester.widget<Text>(
          find.byKey(const Key('search-brand')),
        ).data,
        'Toyota',
      );

      // # Add Car Must Remain Unchanged
      expect(
        tester.widget<Text>(
          find.byKey(const Key('add-car-brand')),
        ).data,
        'No brand selected',
      );

      // # Select Hyundai In Add Car
      await tester.tap(find.byKey(const Key('add-car-select')));
      await tester.pump();

      // # Search Must Still Have Toyota
      expect(
        tester.widget<Text>(
          find.byKey(const Key('search-brand')),
        ).data,
        'Toyota',
      );

      // # Add Car Must Have Hyundai
      expect(
        tester.widget<Text>(
          find.byKey(const Key('add-car-brand')),
        ).data,
        'Hyundai',
      );
    },
  );
}
