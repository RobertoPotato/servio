// To parse this JSON data, do
//
//     final serviceCount = serviceCountFromJson(jsonString);

import 'dart:convert';

ServiceCount serviceCountFromJson(String str) => ServiceCount.fromJson(json.decode(str));

String serviceCountToJson(ServiceCount data) => json.encode(data.toJson());

class ServiceCount {
  ServiceCount({
    this.count,
  });

  int count;

  factory ServiceCount.fromJson(Map<String, dynamic> json) => ServiceCount(
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
  };
}
