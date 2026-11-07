
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:qitai/features/client/auth/presentation/providers/auth_notifier.dart';
import 'package:qitai/features/client/auth/presentation/providers/auth_state.dart';
import 'package:qitai/features/client/categories/presentation/provider/category_provider.dart';
import 'package:qitai/features/client/home/presentation/screens/client_home_screen.dart';
import 'package:qitai/features/client/home/presentation/widgets/add_car_widget.dart';
import 'package:qitai/features/client/products/presentation/provider/all_products_notifier.dart';
import 'package:qitai/features/client/products/presentation/provider/all_products_state.dart';
import 'package:qitai/features/client/user/cars/domain/entities/user_car.dart';
import 'package:qitai/features/client/user/cars/domain/entities/user_car_vehicle.dart';
import 'package:qitai/features/client/user/cars/presentation/providers/user_car_provider.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_notifier.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_state.dart';

// # Prevent Real Product Requests
class RetryTestProductsNotifier extends AllProductsNotifier {
  @override
  AllProductsState build() => const AllProductsState();
}

// # Prevent Real Vehicle Requests
class RetryTestVehicleNotifier extends VehicleNotifier {
  @override
  VehicleState build() => const VehicleState();
}

// # Test Car
UserCar createRetryTestCar() {
  return const UserCar(
    id: 42,
    userId: 1,
    vehicleId: 42,
    nickname: 'سيارة الاختبار',
    isDefault: false,
    createdAt: null,
    updatedAt: null,
    vehicle: UserCarVehicle(
      id: 42,
      brandId: 1,
      modelId: 1,
      yearId: 1,
      vin: 'TEST-VIN-42',
      createdAt: null,
      updatedAt: null,
      attributes: [],
    ),
  );
}

void main() {
  testWidgets(
    'Home shows retry after cars failure and recovers on success',
    (tester) async {
      // # Arrange
      var getCarsCalls = 0;
      final testCar = createRetryTestCar();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // # Authenticated User
            authProvider.overrideWithValue(
              const Authenticated(),
            ),

            // # First Request Fails, Second Succeeds
            userCarsProvider.overrideWith((ref) async {
              getCarsCalls++;

              if (getCarsCalls == 1) {
                throw StateError('Simulated network failure');
              }

              return [testCar];
            }),

            // # Avoid Unrelated API Requests
            categoriesProvider.overrideWith(
              (ref) async => [],
            ),
            allProductsProvider.overrideWith(
              RetryTestProductsNotifier.new,
            ),
            vehicleProvider.overrideWith(
              RetryTestVehicleNotifier.new,
            ),
          ],
          child: const MaterialApp(
            home: Directionality(
              textDirection: TextDirection.rtl,
              child: ClientHomeScreen(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // # Assert Initial Request Failed
      expect(getCarsCalls, 1);

      expect(
        find.text('تعذر تحميل سياراتك'),
        findsOneWidget,
      );

      expect(
        find.text('إعادة المحاولة'),
        findsOneWidget,
      );

      // # A Failure Must Not Look Like An Empty Car List
      expect(
        find.text('اضف سيارتك'),
        findsNothing,
      );

      // # Act: Retry
      await tester.tap(find.text('إعادة المحاولة'));
      await tester.pumpAndSettle();

      // # Assert Request Was Repeated
      expect(
        getCarsCalls,
        2,
        reason: 'Retry must fetch user cars again.',
      );

      // # Assert Error State Disappeared
      expect(
        find.text('تعذر تحميل سياراتك'),
        findsNothing,
      );

      expect(
        find.text('إعادة المحاولة'),
        findsNothing,
      );

      // # Assert Cars Are Now Displayed
      final carFinder = find.byWidgetPredicate(
        (widget) =>
            widget is HomeCarItem && widget.car.id == 42,
      );

      expect(
        carFinder,
        findsOneWidget,
        reason: 'Cars must appear after a successful retry.',
      );
    },
  );
}
