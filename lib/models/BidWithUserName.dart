import 'dart:convert';

BidWithUserName bidWithUserNameFromJson(String str) => BidWithUserName.fromJson(json.decode(str));

String bidWithUserNameToJson(BidWithUserName data) => json.encode(data.toJson());

class BidWithUserName {
  BidWithUserName({
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
    this.user,
  });

  int id;
  double amount;
  String coverLetter;
  bool canTravel;
  String availability;
  String currency;
  int userId;
  int serviceId;
  DateTime createdAt;
  DateTime updatedAt;
  User user;

  factory BidWithUserName.fromJson(Map<String, dynamic> json) => BidWithUserName(
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
    user: User.fromJson(json["User"]),
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
