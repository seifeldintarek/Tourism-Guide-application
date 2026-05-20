class Category {
  // final String id;
  final String name;
  final String quote;
  final String img;

  Category({
    // required this.id,
    required this.name,
    required this.quote,
    required this.img,
  });

  static Category fromMap(Map<String, dynamic> map) {
    return Category(
      // id: map['id'] ?? '',
      name: map['name'] ?? '',
      quote: map['quote'] ?? '',
      img: map['img'] ?? '',
    );
  }

  static Map<String, dynamic> toMap(Category category) {
    return {
      // 'id': category.id,
      'name': category.name,
      'quote': category.quote,
      'img': category.img,
    };
  }
}
