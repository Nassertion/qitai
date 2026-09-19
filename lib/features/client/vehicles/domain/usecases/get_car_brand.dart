import 'package:qitai/features/client/vehicles/domain/entities/car_brand.dart';
import 'package:qitai/features/client/vehicles/domain/repositories/vehicle_repository.dart';

class GetCarBrands {
  final VehicleRepository repo;
  GetCarBrands(this.repo);

  Future<List<CarBrand>> call(){
    return repo.getCarBrands();
  }

}