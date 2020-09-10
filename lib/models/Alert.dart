import 'dart:convert';

Alert alertFromJson(String str) => Alert.fromJson(json.decode(str));

String alertToJson(Alert data) => json.encode(data.toJson());

class Alert {
  Alert({
    this.id,
    this.title,
    this.payload,
    this.createdFor,
    this.isSeen,
    this.type,
    this.createdAt,
  });

  int id;
  String title;
  String payload;
  int createdFor;
  bool isSeen;
  String type;
  DateTime createdAt;

  factory Alert.fromJson(Map<String, dynamic> json) => Alert(
    id: json["id"],
    title: json["title"],
    payload: json["payload"],
    createdFor: json["createdFor"],
    isSeen: json["isSeen"],
    type: json["type"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "payload": payload,
    "createdFor": createdFor,
    "isSeen": isSeen,
    "type": type,
    "createdAt": createdAt.toIso8601String(),
  };
}
