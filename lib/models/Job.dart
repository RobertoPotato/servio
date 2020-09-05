// To parse this JSON data, do
//
//     final job = jobFromJson(jsonString);

import 'dart:convert';

Job jobFromJson(String str) => Job.fromJson(json.decode(str));

String jobToJson(Job data) => json.encode(data.toJson());

class Job {
  Job({
    this.id,
    this.createdAt,
    this.clientId,
    this.agentId,
    this.client,
    this.agent,
    this.bid,
    this.service,
    this.status,
  });

  DateTime createdAt;
  int id;
  int clientId;
  int agentId;
  Ent client;
  Ent agent;
  Bid bid;
  Service service;
  Status status;

  factory Job.fromJson(Map<String, dynamic> json) => Job(
    createdAt: DateTime.parse(json["createdAt"]),
    id: json["id"],
    clientId: json["clientId"],
    agentId: json["agentId"],
    client: Ent.fromJson(json["client"]),
    agent: Ent.fromJson(json["agent"]),
    bid: Bid.fromJson(json["Bid"]),
    service: Service.fromJson(json["Service"]),
    status: Status.fromJson(json["Status"]),
  );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt.toIso8601String(),
    "clientId": clientId,
    "agentId": agentId,
    "client": client.toJson(),
    "agent": agent.toJson(),
    "Bid": bid.toJson(),
    "Service": service.toJson(),
    "Status": status.toJson(),
    "id": id
  };
}

class Ent {
  Ent({
    this.firstName,
    this.lastName,
  });

  String firstName;
  String lastName;

  factory Ent.fromJson(Map<String, dynamic> json) => Ent(
    firstName: json["firstName"],
    lastName: json["lastName"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
  };
}

class Bid {
  Bid({
    this.amount,
    this.coverLetter,
    this.canTravel,
    this.availability,
    this.currency,
    this.createdAt,
  });

  int amount;
  String coverLetter;
  bool canTravel;
  String availability;
  String currency;
  DateTime createdAt;

  factory Bid.fromJson(Map<String, dynamic> json) => Bid(
    amount: json["amount"],
    coverLetter: json["coverLetter"],
    canTravel: json["canTravel"],
    availability: json["availability"],
    currency: json["currency"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "coverLetter": coverLetter,
    "canTravel": canTravel,
    "availability": availability,
    "currency": currency,
    "createdAt": createdAt.toIso8601String(),
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
    this.createdAt,
  });

  String title;
  String description;
  double budgetMin;
  double budgetMax;
  String terms;
  String imageUrl;
  DateTime createdAt;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    title: json["title"],
    description: json["description"],
    budgetMin: json["budgetMin"].toDouble(),
    budgetMax: json["budgetMax"].toDouble(),
    terms: json["terms"],
    imageUrl: json["imageUrl"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "budgetMin": budgetMin,
    "budgetMax": budgetMax,
    "terms": terms,
    "imageUrl": imageUrl,
    "createdAt": createdAt.toIso8601String(),
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
