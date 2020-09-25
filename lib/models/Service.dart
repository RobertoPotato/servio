// To parse this JSON data, do
//
//     final service = serviceFromJson(jsonString);

import 'dart:convert';

Service serviceFromJson(String str) => Service.fromJson(json.decode(str));

String serviceToJson(Service data) => json.encode(data.toJson());

class Service {
  Service({
    this.id,
    this.title,
    this.description,
    this.budgetMin,
    this.budgetMax,
    this.terms,
    this.imageUrl,
    this.county,
    this.town,
    this.userId,
    this.categoryId,
    this.statusId,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  int id;
  String title;
  String description;
  double budgetMin;
  double budgetMax;
  String terms;
  String imageUrl;
  String county;
  String town;
  int userId;
  int categoryId;
  int statusId;
  DateTime createdAt;
  DateTime updatedAt;
  User user;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    budgetMin: json["budgetMin"].toDouble(),
    budgetMax: json["budgetMax"].toDouble(),
    terms: json["terms"],
    imageUrl: json["imageUrl"],
    county: json["county"],
    town: json["town"],
    userId: json["userId"],
    categoryId: json["categoryId"],
    statusId: json["statusId"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    user: User.fromJson(json["User"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "budgetMin": budgetMin,
    "budgetMax": budgetMax,
    "terms": terms,
    "imageUrl": imageUrl,
    "county": county,
    "town": town,
    "userId": userId,
    "categoryId": categoryId,
    "statusId": statusId,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
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
