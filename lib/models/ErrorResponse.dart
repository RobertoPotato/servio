// To parse this JSON data, do
//
//     final error = errorFromJson(jsonString);

import 'dart:convert';

Error errorFromJson(String str) => Error.fromJson(json.decode(str));

String errorToJson(Error data) => json.encode(data.toJson());

class Error {
  Error({
    this.error,
  });

  String error;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
  };
}
