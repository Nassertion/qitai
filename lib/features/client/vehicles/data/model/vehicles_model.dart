class CarBrand {
  final int id;
  final String name;

  CarBrand({
    required this.id,
    required this.name,
  });

  factory CarBrand.fromJson(Map<String, dynamic> json) {
    return CarBrand(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class CarModel {
  final int id;
  final int brandId;
  final String name;

  CarModel({
    required this.id,
    required this.brandId,
    required this.name,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'],
      brandId: json['brand_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand_id': brandId,
      'name': name,
    };
  }
}

class CarYear {
  final int id;
  final int modelId;
  final int year;

  CarYear({
    required this.id,
    required this.modelId,
    required this.year,
  });

  factory CarYear.fromJson(Map<String, dynamic> json) {
    return CarYear(
      id: json['id'],
      modelId: json['model_id'],
      year: json['year'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'model_id': modelId,
      'year': year,
    };
  }
}