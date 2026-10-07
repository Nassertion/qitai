import 'package:qitai/features/client/user/cars/data/models/user_car_vehicle_model.dart';
import 'package:qitai/features/client/user/cars/domain/entites/user_car.dart';

class UserCarModel {
  final int id;
  final int userId;
  final int vehicleId;
  final String? nickname;
  final bool isDefault;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final UserCarVehicleModel vehicle;

  const UserCarModel({
    required this.id,
    required this.userId,
    required this.vehicleId,
    required this.nickname,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
    required this.vehicle,
  });

  factory UserCarModel.fromJson(Map<String, dynamic> json) {
    return UserCarModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      vehicleId: json['vehicle_id'] as int,
      nickname: json['nickname'] as String?,
      isDefault:
          json['is_default'] == true || json['is_default'] == 1,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      vehicle: UserCarVehicleModel.fromJson(
        json['vehicle'] as Map<String, dynamic>,
      ),
    );
  }

  UserCar toEntity() {
    return UserCar(
      id: id,
      userId: userId,
      vehicleId: vehicleId,
      nickname: nickname,
      isDefault: isDefault,
      createdAt: createdAt,
      updatedAt: updatedAt,
      vehicle: vehicle.toEntity(),
    );
  }
}