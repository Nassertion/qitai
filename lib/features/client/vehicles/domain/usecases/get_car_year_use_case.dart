import 'package:qitai/features/client/vehicles/domain/entities/car_year.dart';
import 'package:qitai/features/client/vehicles/domain/repositories/vehicles_repository.dart';

class VehicelsUseCase {
  final VehiclesRepository repo;
  VehicelsUseCase(this.repo);

  Future<List<CarYear>> call(int modelId){
    return repo.getYear(modelId: modelId);
  }

}