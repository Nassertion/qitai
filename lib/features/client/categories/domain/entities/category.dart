class Category {
  final int id;
  final String name;
  final String? iconPath;
  final String? iconUrl;
  final int? parentId;
  final int sortOrder;
  final bool isActive;

const Category({
    required this.id,
    required this.name,
    this.iconPath,
    this.iconUrl,
    this.parentId,
    required this.sortOrder,
    required this.isActive,
  });}