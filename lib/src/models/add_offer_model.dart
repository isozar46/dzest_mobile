// To parse this JSON data, do
//
//     final addOffer = addOfferFromJson(jsonString);

import 'dart:convert';

GetOffer addOfferFromJson(String str) => GetOffer.fromJson(json.decode(str));

String addOfferToJson(GetOffer data) => json.encode(data.toJson());

class GetOffer {
  GetOffer({
    required this.id,
  });

  int id;

  factory GetOffer.fromJson(Map<String, dynamic> json) => GetOffer(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
