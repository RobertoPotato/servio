import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:servio/constants.dart';
import 'package:http/http.dart' as http;
import 'package:servio/jwt_helpers.dart';
import 'package:servio/models/ErrorResponse.dart';

//This runs when a user accepts a certain bid
class MJob {
  final String token;
  final int agentId;
  final int bidId;
  final int serviceId;
  final int statusId;

  MJob(this.token, this.agentId, this.bidId, this.serviceId, this.statusId);
}

Future<String> acceptBid({@required MJob job, @required ctxt}) async {
  final String url = "$kBaseUrl/v1/jobs";
  try {
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
        }).timeout(
      Duration(seconds: kNetworkRequestTimeOutDuration),
    );

    if (response.statusCode == 200) {
      displayResponseCard(ctxt, "Success", "Bid accepted successfully", kSuccessImage);
      return "Bid accepted successfully";
    } else {
      var error = Error.fromJson(json.decode(response.body));
      displayResponseCard(ctxt, kUniversalErrorTitle, error.error, kErrorImage);
      return error.error;
    }
  } on SocketException catch (e) {
    displayResponseCard(ctxt, "Error", kNoConnection, kErrorImage);
  } on TimeoutException catch (e) {
    displayResponseCard(ctxt, "Error", kRequestTimedOut, kErrorImage);
  }
}
