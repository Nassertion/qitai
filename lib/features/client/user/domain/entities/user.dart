class User {
  final int id;
  final String phone;
  final String role;
  final bool isActive;
  final String name;

  final String? email;

  const User({
    required this.id,
    required this.phone,
    required this.role,
    required this.isActive,
    required this.name,

    this.email,
  });
}