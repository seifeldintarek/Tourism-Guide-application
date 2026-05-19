import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget mainImage(BuildContext context, String? url, double height) {
  return Container(
    height: height * .3,
    width: double.infinity,
    child: url != null
        ? CachedNetworkImage(
            imageUrl: url,
            placeholder: (context, url) =>
                SizedBox(child: CircularProgressIndicator(color: Colors.black)),
            fit: BoxFit.cover,
          )
        : Image.asset("assets/images/placeholder/placeholder.jpg"),
  );
}
