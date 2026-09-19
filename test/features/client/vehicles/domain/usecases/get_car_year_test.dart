import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:qitai/features/client/vehicles/domain/entities/car_year.dart';
import 'package:qitai/features/client/vehicles/domain/repositories/vehicles_repository.dart';
import 'package:qitai/features/client/vehicles/domain/usecases/get_car_years.dart';

class MockVehiclesRepository extends Mock implements VehiclesRepository {}

void main() {
  late MockVehiclesRepository repository;
  late GetCarYears getCarYears;

  setUp(() {
    repository = MockVehiclesRepository();
    getCarYears = GetCarYears(repository);
  });

  test('should return car years from repository', () async {
    // Arrange
    const modelId = 1;
    const years = <CarYear>[];

    when(
      () => repository.getCarYears(modelId: modelId),
    ).thenAnswer((_) async => years);

    // Act
    final result = await getCarYears(modelId);

    // Assert
    expect(result, years);

    verify(
      () => repository.getCarYears(modelId: modelId),
    ).called(1);
  });
}