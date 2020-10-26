// To parse this JSON data, do
//
//     final stats = statsFromJson(jsonString);

import 'dart:convert';

Stats statsFromJson(String str) => Stats.fromJson(json.decode(str));

String statsToJson(Stats data) => json.encode(data.toJson());

class Stats {
  Stats({
    this.bidCount,
    this.jobCount,
    this.jobsCompleted,
    this.jobsStalled,
    this.jobsCreated,
    this.servicesCount,
    this.averageRating,
  });

  int bidCount;
  int jobCount;
  int jobsCompleted;
  int jobsStalled;
  int jobsCreated;
  int servicesCount;
  List<AverageRating> averageRating;

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
    bidCount: json["bid_count"],
    jobCount: json["job_count"],
    jobsCompleted: json["jobs_completed"],
    jobsStalled: json["jobs_stalled"],
    jobsCreated: json["jobs_created"],
    servicesCount: json["services_count"],
    averageRating: List<AverageRating>.from(json["average_rating"].map((x) => AverageRating.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "bid_count": bidCount,
    "job_count": jobCount,
    "jobs_completed": jobsCompleted,
    "jobs_stalled": jobsStalled,
    "jobs_created": jobsCreated,
    "services_count": servicesCount,
    "average_rating": List<dynamic>.from(averageRating.map((x) => x.toJson())),
  };
}

class AverageRating {
  AverageRating({
    this.avg,
  });

  double avg;

  factory AverageRating.fromJson(Map<String, dynamic> json) => AverageRating(
    avg: json["avg"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "avg": avg,
  };
}
