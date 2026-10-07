import 'package:qitai/features/client/user/cars/data/models/user_car_attribute_model.dart';
import 'package:qitai/features/client/user/cars/domain/entites/user_car_vehicle.dart';

class UserCarVehicleModel {
  final int id;
  final int brandId;
  final int modelId;
  final int yearId;
  final String vin;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<UserCarAttributeModel> attributes;

  const UserCarVehicleModel({
    required this.id,
    required this.brandId,
    required this.modelId,
    required this.yearId,
    required this.vin,
    required this.createdAt,
    required this.updatedAt,
    required this.attributes,
  });

  factory UserCarVehicleModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return UserCarVehicleModel(
      id: json['id'] as int,
      brandId: json['brand_id'] as int,
      modelId: json['model_id'] as int,
      yearId: json['year_id'] as int,
      vin: json['vin'] as String,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      attributes:
          (json['attributes'] as List<dynamic>? ?? [])
              .map(
                (item) => UserCarAttributeModel.fromJson(
                  item as Map<String, dynamic>,
                ),
              )
              .toList(),
    );
  }

  UserCarVehicle toEntity() {
    return UserCarVehicle(
      id: id,
      brandId: brandId,
      modelId: modelId,
      yearId: yearId,
      vin: vin,
      createdAt: createdAt,
      updatedAt: updatedAt,
      attributes:
          attributes.map((attribute) => attribute.toEntity()).toList(),
    );
  }
}