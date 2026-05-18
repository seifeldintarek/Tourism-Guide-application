import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/Category.dart';
import 'package:flutter_application_1/models/Place.dart';

// Future<void> heritagetodb() async {
//   Category category = Category(name: "heritage", quote: "heritagequote");

//   Map<String, dynamic> data = Category.toMap(category);

//   final doc = FirebaseFirestore.instance.collection("category").doc("heritage");

//   await doc.set(data);
// }

Future<void> todb() async {
  //edit the place data
  Place place = Place(
    id: "pyramids", //nfs esm el place lowercase //XX
    name: "pyramidsname", //XX
    location: "alharam", //XX
    city: "giza", //XX
    mainImage:
        "https://prfwmjmedmfqauccmqgv.supabase.co/storage/v1/object/public/pictures/places/heirtage/pyramids/main%20image/giza-pyramids-cairo-egypt-with-palm.webp",
    category: "heritage", //XX
    rating: 4.7,
    about: "aboutpyramids", //XX
    tags: ["pyramidstag0", "pyramidstag1", "pyramidstag2"], //XX
    ticketPriceEgyptian: 30,
    ticketPrice: 350,
    galleryImages: [
      "https://prfwmjmedmfqauccmqgv.supabase.co/storage/v1/object/public/pictures/places/heirtage/pyramids/gallery%20images/travel-wiser-giza-pyramids-cairo.jpg",
      "https://prfwmjmedmfqauccmqgv.supabase.co/storage/v1/object/public/pictures/places/heirtage/pyramids/gallery%20images/download.jpg",
      "https://prfwmjmedmfqauccmqgv.supabase.co/storage/v1/object/public/pictures/places/heirtage/pyramids/gallery%20images/download%20(1).jpg",
    ],
    mapUrl: "https://maps.app.goo.gl/SGnfQorTBNLPjXK47?g_st=ic",
    bookingUrl: "https://egymonuments.com/book-date/2",
    startHr: 8,
    endHr: 4,
  );

  //the object sent to the firestore
  Map<String, dynamic> data = Place.toMap(place);

  final doc = FirebaseFirestore.instance
      .collection("category")
      .doc("heritage") //change this to match document name in frestore
      .collection("places") //seboha
      .doc(place.id);
  await doc.set(data);
}
