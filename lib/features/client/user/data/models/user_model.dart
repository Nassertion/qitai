import 'package:qitai/features/client/user/domain/entities/user.dart';

class UserModel {
  final int id;
  final String phone;
  final String role;
  final bool isActive;
  final String name;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? email;

  const UserModel({
    required this.id,
    required this.phone,
    required this.role,
    required this.isActive,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      phone: json['phone'] as String,
      role: json['role'] as String,
      isActive: json['is_active'] as bool,
      name: json['name'] as String,
      email: json['email'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  User toEntity() {
    return User(
      id: id,
      phone: phone,
      role: role,
      isActive: isActive,
      name: name,
      email: email,
    );
  }
}