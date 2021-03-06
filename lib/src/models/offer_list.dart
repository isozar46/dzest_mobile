import 'dart:convert';
import 'package:dzest_mobile/src/models/offer_image.dart';

OfferList offersFromJson(String str) =>
    OfferList.fromJson(json.decode(utf8.decode(str.runes.toList())));

String offerToJson(OfferList data) => json.encode(data.toJson());

class OfferList {
  OfferList({
    required this.next,
    required this.results,
  });

  dynamic next;
  List<Result> results;

  factory OfferList.fromJson(Map<String, dynamic> json) => OfferList(
        next: json["next"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "next": next,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
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

  factory Result.fromJson(Map<String, dynamic> json) => Result(
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
