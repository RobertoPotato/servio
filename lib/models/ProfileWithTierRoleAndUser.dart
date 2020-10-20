// To parse this JSON data, do
//
//     final profileWithTierRoleAndUser = profileWithTierRoleAndUserFromJson(jsonString);

import 'dart:convert';

ProfileWithTierRoleAndUser profileWithTierRoleAndUserFromJson(String str) => ProfileWithTierRoleAndUser.fromJson(json.decode(str));

String profileWithTierRoleAndUserToJson(ProfileWithTierRoleAndUser data) => json.encode(data.toJson());

class ProfileWithTierRoleAndUser {
  ProfileWithTierRoleAndUser({
    this.bio,
    this.picture,
    this.phoneNumber,
    this.isVerified,
    this.updatedAt,
    this.tier,
    this.role,
    this.user,
  });

  String bio;
  String picture;
  String phoneNumber;
  bool isVerified;
  DateTime updatedAt;
  Tier tier;
  Role role;
  User user;

  factory ProfileWithTierRoleAndUser.fromJson(Map<String, dynamic> json) => ProfileWithTierRoleAndUser(
    bio: json["bio"],
    picture: json["picture"],
    phoneNumber: json["phoneNumber"],
    isVerified: json["isVerified"],
    updatedAt: DateTime.parse(json["updatedAt"]),
    tier: Tier.fromJson(json["Tier"]),
    role: Role.fromJson(json["Role"]),
    user: User.fromJson(json["User"]),
  );

  Map<String, dynamic> toJson() => {
    "bio": bio,
    "picture": picture,
    "phoneNumber": phoneNumber,
    "isVerified": isVerified,
    "updatedAt": updatedAt.toIso8601String(),
    "Tier": tier.toJson(),
    "Role": role.toJson(),
    "User": user.toJson(),
  };
}

class Role {
  Role({
    this.title,
    this.description,
  });

  String title;
  String description;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
  };
}

class Tier {
  Tier({
    this.title,
    this.description,
    this.badgeUrl,
  });

  String title;
  String description;
  String badgeUrl;

  factory Tier.fromJson(Map<String, dynamic> json) => Tier(
    title: json["title"],
    description: json["description"],
    badgeUrl: json["badgeUrl"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "badgeUrl": badgeUrl,
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
