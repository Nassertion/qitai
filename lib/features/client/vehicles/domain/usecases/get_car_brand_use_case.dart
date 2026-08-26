import 'package:qitai/features/client/vehicles/domain/entities/car_brand.dart';
import 'package:qitai/features/client/vehicles/domain/repositories/vehicles_repository.dart';

class VehicelsUseCase {
  final VehiclesRepository repo;
  VehicelsUseCase(this.repo);

  Future<List<CarBrand>> call(){
    return repo.getBrands();
  }

}