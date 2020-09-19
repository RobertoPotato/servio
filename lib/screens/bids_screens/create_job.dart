import 'dart:convert';
import 'package:servio/constants.dart';
import 'package:http/http.dart' as http;

//This runs when a user accepts a certain bid
class MJob {
  final String token;
  final int agentId;
  final int bidId;
  final int serviceId;
  final int statusId;

  MJob(
      this.token, this.agentId, this.bidId, this.serviceId, this.statusId);
}

Future<String> acceptBid(MJob job) async {
  final String url = "$kBaseUrl/v1/jobs";
  final response = await http.post(Uri.encodeFull(url),
      body: json.encode({
        "agentId": job.agentId,
        "bidId": job.bidId,
        "serviceId": job.serviceId,
        "statusId": job.statusId,
      }),
      headers: {
        "accept": "application/json",
        "content-type": "application/json",
        "x-auth-token": job.token
      });

  if (response.statusCode == 200) {
    return "Bid accepted successfully";
  } else {
    return "Request failed";
  }
}
