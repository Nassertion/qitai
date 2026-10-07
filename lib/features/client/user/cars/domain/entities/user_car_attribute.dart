class UserCarAttribute {
  final int id;
  final int vehicleId;
  final int attributeId;
  final String value;
  final UserCarAttributeInfo attribute;

  const UserCarAttribute({
    required this.id,
    required this.vehicleId,
    required this.attributeId,
    required this.value,
    required this.attribute,
  });
}

class UserCarAttributeInfo {
  final int id;
  final String key;
  final String name;
  final String type;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserCarAttributeInfo({
    required this.id,
    required this.key,
    required this.name,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });
}
class UserCarAttributeInput {
  final String key;
  final String value;

  const UserCarAttributeInput({
    required this.key,
    required this.value,
  });
}