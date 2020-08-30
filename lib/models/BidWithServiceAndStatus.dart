// To parse this JSON data, do
//
//     final bidWithServiceAndStatus = bidWithServiceAndStatusFromJson(jsonString);

import 'dart:convert';

BidWithServiceAndStatus bidWithServiceAndStatusFromJson(String str) => BidWithServiceAndStatus.fromJson(json.decode(str));

String bidWithServiceAndStatusToJson(BidWithServiceAndStatus data) => json.encode(data.toJson());

class BidWithServiceAndStatus {
  BidWithServiceAndStatus({
    this.amount,
    this.coverLetter,
    this.canTravel,
    this.availability,
    this.currency,
    this.updatedAt,
    this.service,
  });

  double amount;
  String coverLetter;
  bool canTravel;
  String availability;
  String currency;
  DateTime updatedAt;
  Service service;

  factory BidWithServiceAndStatus.fromJson(Map<String, dynamic> json) => BidWithServiceAndStatus(
    amount: json["amount"].toDouble(),
    coverLetter: json["coverLetter"],
    canTravel: json["canTravel"],
    availability: json["availability"],
    currency: json["currency"],
    updatedAt: DateTime.parse(json["updatedAt"]),
    service: Service.fromJson(json["Service"]),
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "coverLetter": coverLetter,
    "canTravel": canTravel,
    "availability": availability,
    "currency": currency,
    "updatedAt": updatedAt.toIso8601String(),
    "Service": service.toJson(),
  };
}

class Service {
  Service({
    this.title,
    this.description,
    this.budgetMin,
    this.budgetMax,
    this.terms,
    this.imageUrl,
    this.updatedAt,
    this.status,
  });

  String title;
  String description;
  double budgetMin;
  double budgetMax;
  String terms;
  String imageUrl;
  DateTime updatedAt;
  Status status;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    title: json["title"],
    description: json["description"],
    budgetMin: json["budgetMin"].toDouble(),
    budgetMax: json["budgetMax"].toDouble(),
    terms: json["terms"],
    imageUrl: json["imageUrl"],
    updatedAt: DateTime.parse(json["updatedAt"]),
    status: Status.fromJson(json["Status"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "budgetMin": budgetMin,
    "budgetMax": budgetMax,
    "terms": terms,
    "imageUrl": imageUrl,
    "updatedAt": updatedAt.toIso8601String(),
    "Status": status.toJson(),
  };
}

class Status {
  Status({
    this.title,
    this.description,
  });

  String title;
  String description;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
  };
}
