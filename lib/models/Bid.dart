// To parse this JSON data, do
//
//     final bid = bidFromJson(jsonString);

import 'dart:convert';

Bid bidFromJson(String str) => Bid.fromJson(json.decode(str));

String bidToJson(Bid data) => json.encode(data.toJson());

class Bid {
  Bid({
    this.id,
    this.amount,
    this.coverLetter,
    this.canTravel,
    this.availability,
    this.currency,
    this.userId,
    this.serviceId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int amount;
  String coverLetter;
  bool canTravel;
  String availability;
  String currency;
  int userId;
  int serviceId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Bid.fromJson(Map<String, dynamic> json) => Bid(
    id: json["id"],
    amount: json["amount"].toDouble(),
    coverLetter: json["coverLetter"],
    canTravel: json["canTravel"],
    availability: json["availability"],
    currency: json["currency"],
    userId: json["userId"],
    serviceId: json["serviceId"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "coverLetter": coverLetter,
    "canTravel": canTravel,
    "availability": availability,
    "currency": currency,
    "userId": userId,
    "serviceId": serviceId,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
