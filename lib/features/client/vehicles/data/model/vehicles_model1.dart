class CarBrand1 {
  final int id;
  final String name;

  CarBrand1({
    required this.id,
    required this.name,
  });

  factory CarBrand1.fromJson(Map<String, dynamic> json) {
    return CarBrand1(
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

class CarModel1 {
  final int id;
  final int brandId;
  final String name;

  CarModel1({
    required this.id,
    required this.brandId,
    required this.name,
  });

  factory CarModel1.fromJson(Map<String, dynamic> json) {
    return CarModel1(
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

class CarYear1 {
  final int id;
  final int modelId;
  final int year;

  CarYear1({
    required this.id,
    required this.modelId,
    required this.year,
  });

  factory CarYear1.fromJson(Map<String, dynamic> json) {
    return CarYear1(
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