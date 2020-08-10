// To parse this JSON data, do
//
//     final profileWithTierAndRole = profileWithTierAndRoleFromJson(jsonString);

import 'dart:convert';

ProfileWithTierAndRole profileWithTierAndRoleFromJson(String str) => ProfileWithTierAndRole.fromJson(json.decode(str));

String profileWithTierAndRoleToJson(ProfileWithTierAndRole data) => json.encode(data.toJson());

class ProfileWithTierAndRole {
  ProfileWithTierAndRole({
    this.bio,
    this.picture,
    this.avatar,
    this.phoneNumber,
    this.isVerified,
    this.updatedAt,
    this.tier,
    this.role,
  });

  String bio;
  String picture;
  String avatar;
  String phoneNumber;
  bool isVerified;
  DateTime updatedAt;
  Tier tier;
  Role role;

  factory ProfileWithTierAndRole.fromJson(Map<String, dynamic> json) => ProfileWithTierAndRole(
    bio: json["bio"],
    picture: json["picture"],
    avatar: json["avatar"],
    phoneNumber: json["phoneNumber"],
    isVerified: json["isVerified"],
    updatedAt: DateTime.parse(json["updatedAt"]),
    tier: Tier.fromJson(json["Tier"]),
    role: Role.fromJson(json["Role"]),
  );

  Map<String, dynamic> toJson() => {
    "bio": bio,
    "picture": picture,
    "avatar": avatar,
    "phoneNumber": phoneNumber,
    "isVerified": isVerified,
    "updatedAt": updatedAt.toIso8601String(),
    "Tier": tier.toJson(),
    "Role": role.toJson(),
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
