class ProductDetailModel {
  final int id;
  final String name;
  final String sku;
  final String partNumber;
  final double price;
  final int stock;
  final String stockStatus;
  final String condition;
  final String quality;
  final String description;
  final ProductCategoryModel? category;
  final List<String> images;
  final List<ProductCompatibilityModel> compatibilities;

  const ProductDetailModel({
    required this.id,
    required this.name,
    required this.sku,
    required this.partNumber,
    required this.price,
    required this.stock,
    required this.stockStatus,
    required this.condition,
    required this.quality,
    required this.description,
    required this.category,
    required this.images,
    required this.compatibilities,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      sku: json['sku'] as String? ?? '',
      partNumber: json['part_number'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      stock: json['stock'] as int? ?? 0,
      stockStatus: json['stock_status'] as String? ?? '',
      condition: json['condition'] as String? ?? '',
      quality: json['quality'] as String? ?? '',
      description: json['description'] as String? ?? '',
      category: json['category'] != null
          ? ProductCategoryModel.fromJson(
              json['category'] as Map<String, dynamic>,
            )
          : null,
      images: (json['images'] as List<dynamic>? ?? [])
          .map((item) => item.toString())
          .toList(),
      compatibilities: (json['compatibilities'] as List<dynamic>? ?? [])
          .map(
            (item) => ProductCompatibilityModel.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }
}

class ProductCategoryModel {
  final int id;
  final String name;
  final String? icon;

  const ProductCategoryModel({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductCategoryModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      icon: json['icon'] as String?,
    );
  }
}

class ProductCompatibilityModel {
  final String type;
  final String label;
  final String? vinValue;
  final ProductBrandModel? brand;
  final ProductCarModel? model;
  final int? yearFrom;
  final int? yearTo;

  const ProductCompatibilityModel({
    required this.type,
    required this.label,
    this.vinValue,
    this.brand,
    this.model,
    this.yearFrom,
    this.yearTo,
  });

  factory ProductCompatibilityModel.fromJson(Map<String, dynamic> json) {
    return ProductCompatibilityModel(
      type: json['type'] as String? ?? '',
      label: json['label'] as String? ?? '',
      vinValue: json['vin_value'] as String?,
      brand: json['brand'] != null
          ? ProductBrandModel.fromJson(json['brand'] as Map<String, dynamic>)
          : null,
      model: json['model'] != null
          ? ProductCarModel.fromJson(json['model'] as Map<String, dynamic>)
          : null,
      yearFrom: json['year_from'] as int?,
      yearTo: json['year_to'] as int?,
    );
  }
}

class ProductBrandModel {
  final int id;
  final String name;

  const ProductBrandModel({
    required this.id,
    required this.name,
  });

  factory ProductBrandModel.fromJson(Map<String, dynamic> json) {
    return ProductBrandModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
    );
  }
}

class ProductCarModel {
  final int id;
  final String name;

  const ProductCarModel({
    required this.id,
    required this.name,
  });

  factory ProductCarModel.fromJson(Map<String, dynamic> json) {
    return ProductCarModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
    );
  }
}