// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    this.id,
    this.title,
    this.description,
    this.subCategories,
    this.imageUrl,
    this.themeColor,
  });

  int id;
  String title;
  String description;
  String subCategories;
  String imageUrl;
  String themeColor;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    subCategories: json["subCategories"],
    imageUrl: json["imageUrl"],
    themeColor: json["themeColor"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "subCategories": subCategories,
    "imageUrl": imageUrl,
    "themeColor": themeColor,
  };
}



// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);
/*
import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    this.id,
    this.title,
    this.description,
    this.imageUrl,
    this.themeColor,
  });

  int id;
  String title;
  String description;
  String imageUrl;
  String themeColor;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    imageUrl: json["imageUrl"],
    themeColor: json["themeColor"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "imageUrl": imageUrl,
    "themeColor": themeColor,
  };
}
*/