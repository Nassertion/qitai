class SearchSuggestionModel {
  final int id;
  final String name;
  final String sku;
  final String partNumber;
  final int categoryId;

  const SearchSuggestionModel({
    required this.id,
    required this.name,
    required this.sku,
    required this.partNumber,
    required this.categoryId,
  });

  factory SearchSuggestionModel.fromJson(Map<String, dynamic> json) {
    return SearchSuggestionModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      sku: json['sku'] as String? ?? '',
      partNumber: json['part_number'] as String? ?? '',
      categoryId: json['category_id'] as int? ?? 0,
    );
  }
}