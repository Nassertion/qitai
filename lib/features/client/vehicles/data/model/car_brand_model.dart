import 'package:qitai/features/client/vehicles/domain/entities/car_brand.dart';

class CarBrandModel {
  final int id;
  final String name;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  CarBrandModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CarBrandModel.fromJson(Map<String, dynamic> json) {
    return CarBrandModel(
id: json['id'] as int,
name: json['name'] as String? ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,

      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

 
  CarBrand toEntity() {
    return CarBrand(id: id, name: name);
  }
}
