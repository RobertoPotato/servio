// To parse this JSON data, do
//
//     final categoryIdAndTitle = categoryIdAndTitleFromJson(jsonString);

import 'dart:convert';

CategoryIdAndTitle categoryIdAndTitleFromJson(String str) => CategoryIdAndTitle.fromJson(json.decode(str));

String categoryIdAndTitleToJson(CategoryIdAndTitle data) => json.encode(data.toJson());

class CategoryIdAndTitle {
  CategoryIdAndTitle({
    this.id,
    this.title,
  });

  int id;
  String title;

  factory CategoryIdAndTitle.fromJson(Map<String, dynamic> json) => CategoryIdAndTitle(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}
