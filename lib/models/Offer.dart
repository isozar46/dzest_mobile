import 'dart:convert';

List<Offer> offerFromJson(String str) =>
    List<Offer>.from(json.decode(str).map((x) => Offer.fromJson(x)));

String offerToJson(List<Offer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Offer {
  Offer({
    required this.id,
    required this.owner,
    required this.title,
    this.description,
    this.price,
  });

  int id;
  int owner;
  String title;
  String? description;
  int? price;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"],
        owner: json["owner"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "owner": owner,
        "title": title,
        "description": description,
        "price": price,
      };
}
