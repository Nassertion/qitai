import 'dart:async';

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
import 'package:qitai/features/client/user/cars/domain/entities/user_car_attribute.dart';
import 'package:qitai/features/client/user/cars/domain/entities/user_car_vehicle.dart';
import 'package:qitai/features/client/user/cars/domain/repositories/user_car_repository.dart';
import 'package:qitai/features/client/user/cars/domain/usecases/set_default_user_car.dart';
import 'package:qitai/features/client/user/cars/presentation/providers/user_car_provider.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_brand.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_model.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_year.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_notifier.dart';
import 'package:qitai/features/client/vehicles/presentation/provider/vehicle_state.dart';

// # Fake Repository
class FakeUserCarRepository implements UserCarRepository {
  int setDefaultCalls = 0;

  final pendingRequests = <Completer<UserCar>>[];

  @override
  Future<UserCar> setDefaultUserCar(int id) {
    setDefaultCalls++;

    final request = Completer<UserCar>();
    pendingRequests.add(request);

    return request.future;
  }

  @override
  Future<List<UserCar>> getUserCars() async => [];

  @override
  Future<UserCar> addUserCar({
    required int brandId,
    required int modelId,
    required int yearId,
    required String vin,
    String? nickname,
    required bool isDefault,
    required List<UserCarAttributeInput> attributes,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUserCar(int id) async {}
}

// # Test Products Notifier
// يمنع جلب المنتجات من السيرفر أثناء اختبار الشاشة.
class TestAllProductsNotifier extends AllProductsNotifier {
  @override
  AllProductsState build() => const AllProductsState();
}

// # Test Vehicle Notifier
// يبدأ بسيارة افتراضية مطابقة للبيانات.
// بهذا لا تحتاج الشاشة إلى استدعاء APIs السيارات.
class TestVehicleNotifier extends VehicleNotifier {
  @override
  VehicleState build() {
    return const VehicleState(
      selectedCarBrand: CarBrand(id: 1, name: 'Toyota'),
      selectedModel: CarModel(id: 1, brandId: 1, name: 'Camry'),
      selectedCarYear: CarYear(id: 1, modelId: 1, year: 2023),
    );
  }
}

// # Test Data
UserCar createTestCar(int id, {required bool isDefault}) {
  return UserCar(
    id: id,
    userId: 1,
    vehicleId: id,
    nickname: 'Test Car $id',
    isDefault: isDefault,
    createdAt: null,
    updatedAt: null,
    vehicle: UserCarVehicle(
      id: id,
      brandId: 1,
      modelId: 1,
      yearId: 1,
      vin: 'TEST-VIN-$id',
      createdAt: null,
      updatedAt: null,
      attributes: const [],
    ),
  );
}

void main() {
  testWidgets('ClientHomeScreen prevents duplicate default car requests', (
    tester,
  ) async {
    // # Arrange
    final repository = FakeUserCarRepository();

    final defaultCar = createTestCar(22, isDefault: true);

    final secondCar = createTestCar(23, isDefault: false);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // # Authenticated User
          authProvider.overrideWithValue(const Authenticated()),

          // # Fake Cars
          userCarsProvider.overrideWith((ref) async => [defaultCar, secondCar]),

          // # Fake Default Car API
          setDefaultUserCarProvider.overrideWith(
            (ref) => SetDefaultUserCar(repository),
          ),

          // # Fake Categories
          categoriesProvider.overrideWith((ref) async => []),

          // # Fake Products
          allProductsProvider.overrideWith(TestAllProductsNotifier.new),

          // # Fake Vehicle
          vehicleProvider.overrideWith(TestVehicleNotifier.new),
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

    // # Find Real Car Widget
    final carFinder = find.byWidgetPredicate(
      (widget) => widget is HomeCarItem && widget.car.id == 23,
    );

    expect(carFinder, findsOneWidget);

    // # First Tap
    await tester.tap(carFinder);
    await tester.pump();

    expect(repository.setDefaultCalls, 1);

    // # Second Tap While Request Is Pending
    await tester.tap(carFinder);
    await tester.pump();

    // # Assert No Duplicate Request
    expect(
      repository.setDefaultCalls,
      1,
      reason:
          'ClientHomeScreen must block repeated taps '
          'while changing the default car.',
    );

    // # Complete First Request
    repository.pendingRequests[0].complete(createTestCar(23, isDefault: true));

    await tester.pumpAndSettle();

    // # Request Guard Should Be Released
    // نضغط مرة ثانية بعد انتهاء الطلب.
    await tester.tap(carFinder);
    await tester.pump();

    expect(
      repository.setDefaultCalls,
      2,
      reason:
          'A new request should be allowed '
          'after the previous request completes.',
    );

    // # Complete Second Request
    repository.pendingRequests[1].complete(createTestCar(23, isDefault: true));

    await tester.pumpAndSettle();
  });
}
