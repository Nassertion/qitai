import 'package:qitai/features/client/vehicles/domain/entities/car_year.dart';
import 'package:qitai/features/client/vehicles/domain/repositories/vehicle_repository.dart';

class GetCarYears {
  final VehicleRepository repo;
  GetCarYears(this.repo);

  Future<List<CarYear>> call(int modelId){
    return repo.getCarYears(modelId: modelId);
  }

}