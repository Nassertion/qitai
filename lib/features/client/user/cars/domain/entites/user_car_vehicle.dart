import 'user_car_attribute.dart';

class UserCarVehicle {
  final int id;
  final int brandId;
  final int modelId;
  final int yearId;
  final String vin;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<UserCarAttribute> attributes;

  const UserCarVehicle({
    required this.id,
    required this.brandId,
    required this.modelId,
    required this.yearId,
    required this.vin,
    required this.createdAt,
    required this.updatedAt,
    required this.attributes,
  });
}