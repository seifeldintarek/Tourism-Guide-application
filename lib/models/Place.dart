class Place {
  final String id;
  final String name;
  final String location; //elmntqa
  final String city;
  final String mainImage;
  final String category; // Heritage, Food, Spiritual, Nature
  final double rating;
  final String about; // desc
  final List<String> tags;
  final String status; // calculated
  final String hours;
  final String ticketPrice;
  final List<String> galleryImages; //detailed pics
  final String mapUrl;
  final String bookingUrl;

  Place({
    required this.id,
    required this.name,
    required this.location,
    required this.city,
    required this.mainImage,
    required this.category,
    required this.rating,
    required this.about,
    required this.tags,
    required this.status,
    required this.hours,
    required this.ticketPrice,
    required this.galleryImages,
    required this.mapUrl,
    required this.bookingUrl,
  });

  //from db
  static Place fromMap(Map<String, dynamic> map) {
    return Place(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      location: map['location'] ?? '',
      city: map['city'] ?? '',
      mainImage: map['mainImage'] ?? '',
      category: map['category'] ?? '',
      rating: (map['rating'] != null)
          ? double.tryParse(map['rating'].toString()) ?? 0.0
          : 0.0,
      about: map['about'] ?? '',
      tags: List<String>.from(map['tags'] ?? []),
      status: map['status'] ?? '',
      hours: map['hours'] ?? '',
      ticketPrice: map['ticketPrice'] ?? '',
      galleryImages: List<String>.from(map['galleryImages'] ?? []),
      mapUrl: map['mapUrl'] ?? '',
      bookingUrl: map['bookingUrl'] ?? '',
    );
  }

  //todb
  static Map<String, dynamic> toMap(Place place) {
    return {
      'id': place.id,
      'name': place.name,
      'location': place.location,
      'city': place.city,
      'mainImage': place.mainImage,
      'category': place.category,
      'rating': place.rating.toString(),
      'about': place.about,
      'tags': place.tags,
      'status': place.status,
      'hours': place.hours,
      'ticketPrice': place.ticketPrice,
      'galleryImages': place.galleryImages,
      'mapUrl': place.mapUrl,
      'bookingUrl': place.bookingUrl,
    };
  }
}
