// To parse this JSON data, do
//
//     final reviewWithUser = reviewWithUserFromJson(jsonString);

import 'dart:convert';

ReviewWithUser reviewWithUserFromJson(String str) => ReviewWithUser.fromJson(json.decode(str));

String reviewWithUserToJson(ReviewWithUser data) => json.encode(data.toJson());

class ReviewWithUser {
  ReviewWithUser({
    this.stars,
    this.content,
    this.clientId,
    this.createdAt,
    this.user,
  });

  double stars;
  String content;
  int clientId;
  DateTime createdAt;
  User user;

  factory ReviewWithUser.fromJson(Map<String, dynamic> json) => ReviewWithUser(
    stars: json["stars"].toDouble(),
    content: json["content"],
    clientId: json["clientId"],
    createdAt: DateTime.parse(json["createdAt"]),
    user: User.fromJson(json["User"]),
  );

  Map<String, dynamic> toJson() => {
    "stars": stars,
    "content": content,
    "clientId": clientId,
    "createdAt": createdAt.toIso8601String(),
    "User": user.toJson(),
  };
}

class User {
  User({
    this.firstName,
    this.lastName,
  });

  String firstName;
  String lastName;

  factory User.fromJson(Map<String, dynamic> json) => User(
    firstName: json["firstName"],
    lastName: json["lastName"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
  };
}
