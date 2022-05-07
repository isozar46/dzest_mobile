import 'dart:convert';

List<Offer> offerFromJson(String str) =>
    List<Offer>.from(json.decode(str).map((x) => Offer.fromJson(x)));

String offerToJson(List<Offer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Offer {
  Offer({
    required this.id,
    required this.ownerName,
    required this.title,
    required this.description,
    required this.price,
  });

  int id;
  String ownerName;
  String title;
  String description;
  int price;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"],
        ownerName: json["owner_name"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "owner_name": ownerName,
        "title": title,
        "description": description,
        "price": price,
      };
}
