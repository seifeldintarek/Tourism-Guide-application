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
  final int startHr;
  final int endHr;
  final int? ticketPrice;
  final List<String> galleryImages; //detailed pics
  final String mapUrl;
  final String bookingUrl;
  final int? ticketPriceEgyptian;

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
    required this.startHr,
    required this.endHr,
    required this.ticketPrice,
    required this.galleryImages,
    required this.mapUrl,
    required this.bookingUrl,
    required this.ticketPriceEgyptian,
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
      ticketPriceEgyptian: map['ticketPriceEgyptian'] ?? null,
      ticketPrice: map['ticketPrice'] ?? null,
      galleryImages: List<String>.from(map['galleryImages'] ?? []),
      mapUrl: map['mapUrl'] ?? '',
      bookingUrl: map['bookingUrl'] ?? '',
      startHr: map['starthr'] ?? 0,
      endHr: map['endHr'] ?? 0,
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
      'starthr': place.startHr,
      'endHr': place.endHr,
      'ticketPrice': place.ticketPrice ?? null,
      'ticketPriceEgyptian': place.ticketPriceEgyptian ?? null,
      'galleryImages': place.galleryImages,
      'mapUrl': place.mapUrl,
      'bookingUrl': place.bookingUrl,
    };
  }
}
