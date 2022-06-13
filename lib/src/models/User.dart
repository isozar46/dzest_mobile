import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.id,
    required this.agencyId,
    required this.clientId,
    required this.username,
    required this.email,
    required this.isAgency,
    required this.isClient,
  });

  int id;
  dynamic agencyId;
  dynamic clientId;
  String username;
  String email;
  bool isAgency;
  bool isClient;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        agencyId: json["agency_id"],
        clientId: json["client_id"],
        username: json["username"],
        email: json["email"],
        isAgency: json["is_agency"],
        isClient: json["is_client"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "agency_id": agencyId,
        "client_id": clientId,
        "username": username,
        "email": email,
        "is_agency": isAgency,
        "is_client": isClient,
      };
}
