
import 'package:qitai/features/client/user/cars/domain/entities/user_car_attribute.dart';

class UserCarAttributeModel {
  final int id;
  final int vehicleId;
  final int attributeId;
  final String value;
  final UserCarAttributeInfoModel attribute;

  const UserCarAttributeModel({
    required this.id,
    required this.vehicleId,
    required this.attributeId,
    required this.value,
    required this.attribute,
  });

  factory UserCarAttributeModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return UserCarAttributeModel(
      id: json['id'] as int,
      vehicleId: json['vehicle_id'] as int,
      attributeId: json['attribute_id'] as int,
      value: json['value'] as String,
      attribute: UserCarAttributeInfoModel.fromJson(
        json['attribute'] as Map<String, dynamic>,
      ),
    );
  }

  UserCarAttribute toEntity() {
    return UserCarAttribute(
      id: id,
      vehicleId: vehicleId,
      attributeId: attributeId,
      value: value,
      attribute: attribute.toEntity(),
    );
  }
}

class UserCarAttributeInfoModel {
  final int id;
  final String key;
  final String name;
  final String type;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserCarAttributeInfoModel({
    required this.id,
    required this.key,
    required this.name,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserCarAttributeInfoModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return UserCarAttributeInfoModel(
      id: json['id'] as int,
      key: json['key'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  UserCarAttributeInfo toEntity() {
    return UserCarAttributeInfo(
      id: id,
      key: key,
      name: name,
      type: type,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}