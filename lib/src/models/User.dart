import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.key,
  });

  String key;

  factory User.fromJson(Map<String, dynamic> json) => User(
        key: json["key"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
      };
}
