import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_model.dart';
import 'package:qitai/features/client/vehicles/domain/repositories/vehicle_repository.dart';
import 'package:qitai/features/client/vehicles/domain/usecases/get_car_models.dart';

class MockVehiclesRepository extends Mock implements VehicleRepository {}

void main() {
  late MockVehiclesRepository repository;
  late GetCarModels getCarModels;

  setUp(() {
    repository = MockVehiclesRepository();
    getCarModels = GetCarModels(repository);
  });

  test('should return car models from repository', () async {
    // Arrange
    const brandId = 1;
    const models = <CarModel>[];

    when(
      () => repository.getCarModels(brandId: brandId),
    ).thenAnswer((_) async => models);

    // Act
    final result = await getCarModels(brandId);

    // Assert
    expect(result, models);

    verify(
      () => repository.getCarModels(brandId: brandId),
    ).called(1);
  });
}