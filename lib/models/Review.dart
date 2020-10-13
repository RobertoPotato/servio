// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';

Review reviewFromJson(String str) => Review.fromJson(json.decode(str));

String reviewToJson(Review data) => json.encode(data.toJson());

class Review {
  Review({
    this.id,
    this.stars,
    this.content,
    this.reviewerId,
    this.updatedAt,
  });

  int id;
  int stars;
  String content;
  int reviewerId;
  DateTime updatedAt;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["id"],
    stars: json["stars"],
    content: json["content"],
    reviewerId: json["reviewerId"],
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "stars": stars,
    "content": content,
    "reviewerId": reviewerId,
    "updatedAt": updatedAt.toIso8601String(),
  };
}
