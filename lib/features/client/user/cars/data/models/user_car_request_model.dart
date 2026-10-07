class UserCarRequestModel {
  final int brandId;
  final int modelId;
  final int yearId;
  final String vin;
  final String? nickname;
  final bool isDefault;
  final List<UserCarRequestAttributeModel> attributes;

  const UserCarRequestModel({
    required this.brandId,
    required this.modelId,
    required this.yearId,
    required this.vin,
    required this.nickname,
    required this.isDefault,
    required this.attributes,
  });

  Map<String, dynamic> toJson() {
    return {
      'brand_id': brandId,
      'model_id': modelId,
      'year_id': yearId,
      'vin': vin,
      'nickname': nickname,
      'is_default': isDefault,
      'attributes': attributes
          .map((attribute) => attribute.toJson())
          .toList(),
    };
  }
}

class UserCarRequestAttributeModel {
  final String key;
  final String value;

  const UserCarRequestAttributeModel({
    required this.key,
    required this.value,
  });

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value,
    };
  }
}