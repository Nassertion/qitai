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
  final int carBrandId;
  final String name;

  CarModel({
    required this.id,
    required this.carBrandId,
    required this.name,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'],
      carBrandId: json['CarBrand_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'CarBrand_id': carBrandId,
      'name': name,
    };
  }
}

class CarYear {
  final int id;
  final int modelId;
  final String name;

  CarYear({
    required this.id,
    required this.modelId,
    required this.name,
  });

  factory CarYear.fromJson(Map<String, dynamic> json) {
    return CarYear(
      id: json['id'],
      modelId: json['model_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'model_id': modelId,
      'name': name,
    };
  }
}