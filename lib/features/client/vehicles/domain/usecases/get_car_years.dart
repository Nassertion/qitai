import 'package:qitai/features/client/vehicles/domain/entities/car_year.dart';
import 'package:qitai/features/client/vehicles/domain/repositories/vehicles_repository.dart';

class GetCarYears {
  final VehiclesRepository repo;
  GetCarYears(this.repo);

  Future<List<CarYear>> call(int modelId){
    return repo.getCarYears(modelId: modelId);
  }

}