
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:qitai/features/client/user/cars/domain/entities/user_car.dart';
import 'package:qitai/features/client/user/cars/presentation/providers/user_car_provider.dart';

// # TEST SCREEN
// شاشة صغيرة لمحاكاة وجود الصفحة الرئيسية وخروجها من الشجرة.
class TestHomeNavigation extends StatefulWidget {
  const TestHomeNavigation({super.key});

  @override
  State<TestHomeNavigation> createState() => _TestHomeNavigationState();
}

class _TestHomeNavigationState extends State<TestHomeNavigation> {
  bool isHome = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            key: const Key('navigate'),
            onPressed: () {
              setState(() {
                isHome = !isHome;
              });
            },
            child: const Text('تغيير الشاشة'),
          ),

          if (isHome)
            const _TestHomeContent()
          else
            const Text(
              'صفحة ثانية',
              key: Key('other_screen'),
            ),
        ],
      ),
    );
  }
}

// # HOME PROVIDER LISTENER
class _TestHomeContent extends ConsumerWidget {
  const _TestHomeContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cars = ref.watch(userCarsProvider);

    return cars.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
      data: (value) => Text(
        'Cars: ${value.length}',
        key: const Key('cars_result'),
      ),
    );
  }
}

void main() {
  testWidgets(
    'Returning to home should not refetch unchanged cars',
    (tester) async {
      // # ARRANGE
      int getCarsCalls = 0;

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userCarsProvider.overrideWith((ref) async {
              getCarsCalls++;

              // لا نحتاج سيارات حقيقية لاختبار عدد الطلبات.
              return <UserCar>[];
            }),
          ],
          child: const MaterialApp(
            home: TestHomeNavigation(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // # INITIAL LOAD
      expect(getCarsCalls, 1);

      // # NAVIGATE AWAY
      await tester.tap(find.byKey(const Key('navigate')));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const Key('other_screen')),
        findsOneWidget,
      );

      // # RETURN HOME
      await tester.tap(find.byKey(const Key('navigate')));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const Key('cars_result')),
        findsOneWidget,
      );

      // # EXPECTED CACHING BEHAVIOR
      expect(
        getCarsCalls,
        1,
        reason:
            'Returning without changes should reuse the cars data.',
      );
    },
  );
}
