import 'package:qitai/features/client/vehicles/domain/entities/car_year.dart';

class CarYearModel {
  final int id;
  final int modelId;
  final int year;  final DateTime? createdAt;
  final DateTime? updatedAt;

  CarYearModel({required this.id, required this.modelId, required this.year,    required this.createdAt,
    required this.updatedAt,});

  factory CarYearModel.fromJson(Map<String, dynamic> json) {
    return CarYearModel(
id: json['id'] as int,
      modelId: json['model_id'] as int,
      year: json['year'],      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,

      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  CarYear toEntity() {
    return CarYear(id: id, modelId: modelId, year: year);
  }
}
