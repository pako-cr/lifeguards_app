// To parse this JSON data, do
//
//     final serverErrorResponse = serverErrorResponseFromJson(jsonString);

import 'dart:convert';

ServerErrorResponse serverErrorResponseFromJson(String str) =>
    ServerErrorResponse.fromJson(json.decode(str));

String serverErrorResponseToJson(ServerErrorResponse data) =>
    json.encode(data.toJson());

class ServerErrorResponse {
  ServerErrorResponse({
    required this.ok,
    required this.error,
  });

  bool ok;
  ServerError error;

  factory ServerErrorResponse.fromJson(Map<String, dynamic> json) =>
      ServerErrorResponse(
        ok: json["ok"],
        error: ServerError.fromJson(json["errors"]),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "errors": error.toJson(),
      };
}

class ServerError {
  ServerError({
    required this.message,
  });

  String message;

  factory ServerError.fromJson(Map<String, dynamic> json) {
    var error =
        'Unknown error. Please try again. If the problem persist please contact the administrator.';

    if (json["email"] != null) {
      error = json["email"]['msg'];
    } else if (json["password"] != null) {
      error = json["password"]["msg"];
    } else if (json["error"] != null) {
      error = json["error"]["msg"];
    }

    return ServerError(message: error);
  }

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
