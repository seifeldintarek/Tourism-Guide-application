class Category {
  // final String id;
  final String name;
  final String quote;

  Category({
    // required this.id,
    required this.name,
    required this.quote,
  });

  static Category fromMap(Map<String, dynamic> map) {
    return Category(
      // id: map['id'] ?? '',
      name: map['name'] ?? '',
      quote: map['quote'] ?? '',
    );
  }

  static Map<String, dynamic> toMap(Category category) {
    return {
      // 'id': category.id,
      'name': category.name,
      'quote': category.quote,
    };
  }
}
