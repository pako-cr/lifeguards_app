// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.email,
    required this.name,
    required this.uid,
  });

  String email;
  String name;
  String uid;

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        name: json["name"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "uid": uid,
      };
}
