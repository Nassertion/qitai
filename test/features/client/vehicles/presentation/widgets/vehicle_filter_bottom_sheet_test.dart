
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:qitai/core/widgets/app_skeleton.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_brand.dart';
import 'package:qitai/features/client/vehicles/presentation/widgets/vehicle_filter_bottom_sheet.dart';

// # Fake State For Widget Testing
final testBrandsProvider = StateProvider<List<CarBrand>>(
  (ref) => const [],
);

final testBrandsLoadingProvider = StateProvider<bool>(
  (ref) => true,
);

void main() {
  testWidgets(
    'Brand bottom sheet updates from skeleton to brands without reopening',
    (tester) async {
      // # Arrange
      final container = ProviderContainer();

      addTearDown(container.dispose);

      const toyota = CarBrand(
        id: 1,
        name: 'Toyota',
      );

      const hyundai = CarBrand(
        id: 2,
        name: 'Hyundai',
      );

      CarBrand? selectedBrand;

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return Center(
                    child: ElevatedButton(
                      onPressed: () {
                        VehicleFilterBottomSheet.show<CarBrand>(
                          context: context,
                          items: const [],
                          title: 'اختر نوع البراند',
                          getLabel: (brand) => brand.name,

                          // # Reactive State
                          watchItems: (ref) =>
                              ref.watch(testBrandsProvider),
                          watchLoading: (ref) =>
                              ref.watch(testBrandsLoadingProvider),

                          onSelected: (brand) {
                            selectedBrand = brand;
                          },
                        );
                      },
                      child: const Text('فتح البراند'),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );

      // # Open Before Loading Completes
      await tester.tap(find.text('فتح البراند'));
      await tester.pump();
      await tester.pump(
        const Duration(milliseconds: 300),
      );

      // # Skeleton Must Be Visible
      expect(
        find.text('اختر نوع البراند'),
        findsOneWidget,
      );

      expect(
        find.byType(AppSkeleton),
        findsWidgets,
      );

      expect(
        find.text('لا توجد خيارات متاحة'),
        findsNothing,
      );

      expect(find.text('Toyota'), findsNothing);

      // # Simulate API Completion
      container.read(testBrandsProvider.notifier).state = const [
        toyota,
        hyundai,
      ];

      container.read(testBrandsLoadingProvider.notifier).state =
          false;

      await tester.pump();
      await tester.pump(
        const Duration(milliseconds: 300),
      );

      // # Brands Must Appear Without Reopening
      expect(
        find.text('اختر نوع البراند'),
        findsOneWidget,
      );

      expect(
        find.byType(AppSkeleton),
        findsNothing,
      );

      expect(
        find.text('Toyota'),
        findsOneWidget,
      );

      expect(
        find.text('Hyundai'),
        findsOneWidget,
      );

      expect(
        find.text('لا توجد خيارات متاحة'),
        findsNothing,
      );

      // # Select Brand
      await tester.tap(find.text('Toyota'));
      await tester.pumpAndSettle();

      expect(selectedBrand?.id, 1);

      // # Bottom Sheet Must Close
      expect(
        find.text('اختر نوع البراند'),
        findsNothing,
      );
    },
  );
}
