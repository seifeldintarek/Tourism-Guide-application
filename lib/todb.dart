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
    id: "philae_temple", //nfs esm el place lowercase //XX
    name: "philaetemplename", //XX
    location: "philaetemplelocation", //XX
    city: "aswan", //XX
    mainImage:
        "https://prfwmjmedmfqauccmqgv.supabase.co/storage/v1/object/public/pictures/places/heirtage/Philae%20Temple/main%20image/templo-fachada-philae.jpg",
    category: "heritage", //XX
    rating: 4.7,
    about: "aboutphilaetemple", //XX
    tags: ["philaetempletag0", "philaetempletag1", "philaetempletag2"], //XX
    ticketPriceEgyptian: 20,
    ticketPrice: 275,
    galleryImages: [
      "https://prfwmjmedmfqauccmqgv.supabase.co/storage/v1/object/public/pictures/places/heirtage/Philae%20Temple/gallery%20images/hathor-capitals-philae-island-egypt.jpg",
      "https://prfwmjmedmfqauccmqgv.supabase.co/storage/v1/object/public/pictures/places/heirtage/Philae%20Temple/gallery%20images/images.jpg",
      "https://prfwmjmedmfqauccmqgv.supabase.co/storage/v1/object/public/pictures/places/heirtage/Philae%20Temple/gallery%20images/island-of-philae.jpg",
    ],
    mapUrl: "https://maps.app.goo.gl/A3T1D3y7TvswTqZT8?g_st=ic",
    bookingUrl: "https://egymonuments.com/book-date/18",
    startHr: 7,
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
