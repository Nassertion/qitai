import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qitai/features/client/vehicles/domain/entities/car_brand.dart';
import 'package:qitai/features/client/vehicles/domain/repositories/vehicles_repository.dart';
import 'package:qitai/features/client/vehicles/domain/usecases/get_car_brand.dart';

class MockVehiclesRepository extends Mock implements VehiclesRepository {}

void main() {
  late MockVehiclesRepository repository;
  late GetCarBrands getCarBrands;

  setUp(() {
    repository = MockVehiclesRepository();
    getCarBrands = GetCarBrands(repository);
  });

  test('should return car brands from repository', () async {
    // Arrange
    const brands = <CarBrand>[];

    when(
      () => repository.getCarBrands(),
    ).thenAnswer((_) async => brands);

    // Act
    final result = await getCarBrands();

    // Assert
    expect(result, brands);

    verify(
      () => repository.getCarBrands(),
    ).called(1);
  });
}