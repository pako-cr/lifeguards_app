// To parse this JSON data, do
//
//     final signInResponse = signInResponseFromJson(jsonString);

import 'dart:convert';

import 'package:lifeguards_app/models/user.dart';

SignInResponse? signInResponseFromJson(String str) =>
    SignInResponse.fromJson(json.decode(str));

String signInResponseToJson(SignInResponse data) => json.encode(data.toJson());

class SignInResponse {
  SignInResponse({
    required this.ok,
    required this.user,
    required this.token,
  });

  bool ok;
  User user;
  String token;

  factory SignInResponse.fromJson(Map<String, dynamic> json) => SignInResponse(
        ok: json["ok"],
        user: User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "user": user.toJson(),
        "token": token,
      };
}
