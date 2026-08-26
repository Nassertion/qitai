import 'package:qitai/features/client/vehicles/domain/entities/car_model.dart';

class CarModelModel {
  final int id;
  final int brandId;
  final String name;
    final DateTime? createdAt;
  final DateTime? updatedAt;

  CarModelModel({
    required this.id,
    required this.brandId,
    required this.name,
        required this.createdAt,
    required this.updatedAt,
  });

  factory CarModelModel.fromJson(Map<String, dynamic> json) {
    return CarModelModel(
id: json['id'] as int,
name: json['name'] as String? ?? '',
brandId: json['brand_id'] as int,
            createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,

      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }


  CarModel toEntity(){
    return CarModel(id: id, brandId: brandId, name: name);
  }
}