import 'user_car_vehicle.dart';

class UserCar {
  final int id;
  final int userId;
  final int vehicleId;
  final String? nickname;
  final bool isDefault;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final UserCarVehicle vehicle;

  const UserCar({
    required this.id,
    required this.userId,
    required this.vehicleId,
    required this.nickname,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
    required this.vehicle,
  });
}