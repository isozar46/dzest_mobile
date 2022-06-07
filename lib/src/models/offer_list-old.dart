// To parse this JSON data, do
//
//     final offer = offerFromJson(jsonString);

import 'dart:convert';

import 'package:dzest_mobile/src/models/offer_image.dart';

List<OfferList> offersFromJson(String str) =>
    List<OfferList>.from(json.decode(str).map((x) => OfferList.fromJson(x)));

String offerToJson(List<OfferList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OfferList {
  OfferList({
    required this.id,
    required this.ownerName,
    required this.title,
    required this.description,
    required this.price,
    required this.created,
    required this.state,
    required this.images,
  });

  int id;
  String ownerName;
  String title;
  String description;
  int price;
  String created;
  String state;
  List<OfferImage> images;

  factory OfferList.fromJson(Map<String, dynamic> json) => OfferList(
        id: json["id"],
        ownerName: json["owner_name"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        created: json["created"],
        state: json["state"],
        images: List<OfferImage>.from(json["images"].map((x) => OfferImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "owner_name": ownerName,
        "title": title,
        "description": description,
        "price": price,
        "created": created,
        "state": state,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}
