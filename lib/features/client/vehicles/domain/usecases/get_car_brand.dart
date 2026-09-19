import 'package:qitai/features/client/vehicles/domain/entities/car_brand.dart';
import 'package:qitai/features/client/vehicles/domain/repositories/vehicles_repository.dart';

class GetCarBrands {
  final VehiclesRepository repo;
  GetCarBrands(this.repo);

  Future<List<CarBrand>> call(){
    return repo.getCarBrands();
  }

}