import 'package:qitai/features/client/vehicles/domain/entities/car_model.dart';
import 'package:qitai/features/client/vehicles/domain/repositories/vehicles_repository.dart';

class VehicelsUseCase {
  final VehiclesRepository repo;
  VehicelsUseCase(this.repo);

  Future<List<CarModel>> call(int brandId){
    return repo.getModels(brandId : brandId);
  }

}