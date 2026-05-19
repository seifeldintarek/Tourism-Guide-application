class Category {
  final String id;
  final String name;
  final String imageUrl;
  final String quote;

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.quote,
  });

  static Category fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      imageUrl: map['image_url'] ?? '',
      quote: map['quote'] ?? '',
    );
  }

  static Map<String, dynamic> toMap(Category category) {
    return {
      'id': category.id,
      'name': category.name,
      'image_url': category.imageUrl,
      'quote': category.quote,
    };
  }
}
