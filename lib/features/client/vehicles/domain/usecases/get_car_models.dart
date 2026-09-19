import 'package:qitai/features/client/vehicles/domain/entities/car_model.dart';
import 'package:qitai/features/client/vehicles/domain/repositories/vehicle_repository.dart';

class GetCarModels {
  final VehicleRepository repo;
  GetCarModels(this.repo);

  Future<List<CarModel>> call(int brandId){
    return repo.getCarModels(brandId : brandId);
  }

}