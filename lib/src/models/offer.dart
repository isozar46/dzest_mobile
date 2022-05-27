// To parse this JSON data, do
//
//     final offer = offerFromJson(jsonString);

import 'dart:convert';

import 'package:dzest_mobile/src/models/offer_image.dart';

Offer offerFromJson(String str) => Offer.fromJson(json.decode(str));

String offerToJson(Offer data) => json.encode(data.toJson());

class Offer {
  Offer({
    required this.id,
    required this.ownerName,
    required this.title,
    required this.description,
    required this.price,
    required this.created,
    required this.state,
    required this.images,
    required this.comments,
  });

  int id;
  String ownerName;
  String title;
  String description;
  int price;
  String created;
  String state;
  List<OfferImage> images;
  List<Comment> comments;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"],
        ownerName: json["owner_name"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        created: json["created"],
        state: json["state"],
        images: List<OfferImage>.from(json["images"].map((x) => OfferImage.fromJson(x))),
        comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
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
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
      };
}

class Comment {
  Comment({
    required this.id,
    required this.user,
    required this.text,
    required this.created,
    required this.depth,
    required this.refrence,
    required this.replies,
  });

  int id;
  String user;
  String text;
  String created;
  int depth;
  int? refrence;
  List<Comment> replies;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        user: json["user"],
        text: json["text"],
        created: json["created"],
        depth: json["depth"],
        refrence: json["refrence"] == null ? null : json["refrence"],
        replies: List<Comment>.from(json["replies"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "text": text,
        "created": created,
        "depth": depth,
        "refrence": refrence == null ? null : refrence,
        "replies": List<dynamic>.from(replies.map((x) => x.toJson())),
      };
}
