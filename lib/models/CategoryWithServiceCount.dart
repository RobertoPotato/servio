// To parse this JSON data, do
//
//     final categoryWithServiceCount = categoryWithServiceCountFromJson(jsonString);

import 'dart:convert';

CategoryWithServiceCount categoryWithServiceCountFromJson(String str) => CategoryWithServiceCount.fromJson(json.decode(str));

String categoryWithServiceCountToJson(CategoryWithServiceCount data) => json.encode(data.toJson());

class CategoryWithServiceCount {
  CategoryWithServiceCount({
    this.id,
    this.title,
    this.description,
    this.imageUrl,
    this.themeColor,
    this.serviceCount,
  });

  int id;
  String title;
  String description;
  String imageUrl;
  String themeColor;
  String serviceCount;

  factory CategoryWithServiceCount.fromJson(Map<String, dynamic> json) => CategoryWithServiceCount(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    imageUrl: json["imageUrl"],
    themeColor: json["themeColor"],
    serviceCount: json["serviceCount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "imageUrl": imageUrl,
    "themeColor": themeColor,
    "serviceCount": serviceCount,
  };
}
