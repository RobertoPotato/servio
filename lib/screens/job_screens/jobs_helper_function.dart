import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:servio/models/Review.dart';
import 'package:servio/components/review_card.dart';
import 'package:servio/models/ErrorResponse.dart';
import 'package:servio/components/create_review.dart';

//only runs if the status of the job is marked complete

Future fetchReviewOrEmpty(String token, int jobId) async {
  final String url = "$kBaseUrl/v1/reviews/job/$jobId";

  final response = await http.get(Uri.encodeFull(url), headers: {
    "accept": "application/json",
    "content-type": "application/json",
    "x-auth-token": "$token",
  });

  if (response.statusCode == 200) {
    print(response.body);
    return Review.fromJson(json.decode(response.body));
  } else if (response.statusCode == 404) {
    var error = Error.fromJson(json.decode(response.body));
    print(error.error);
    return error;
  } else if (response.statusCode == 400) {
    return Error.fromJson(json.decode(response.body));
  } else {
    throw Exception("Couldn't fetch review");
  }
}

//return a widget that shows a review if available or a button telling you to
//leave a review if not, or an error if we couldn't fetch the review
Widget seeReviewOrError(futureReview, ctxt, token, userId, userName) {
  return FutureBuilder(
    future: futureReview,
    builder: (ctxt, reviewSnapshot) {
      if (reviewSnapshot.hasData) {
        return reviewSnapshot.data.toString().trim() != "No review"
            ? Container(
                child: FlatButton(
                  color: kPrimaryColor,
                  onPressed: () {
                    displayCreateReviewCard(ctxt, token, userId, userName);
                    print("Show popup that lets user write a review");
                  },
                  child: Text(
                    "Write a review",
                    style: kTestTextStyleWhite,
                  ),
                ),
              )
            : ReviewCard(
                rating: 5.0,
                review: "Lorem ipsum",
                reviewerName: "By me",
              );
      } else if (reviewSnapshot.hasError) {
        return Text(
            'Failed to load review: ${reviewSnapshot.error} ${reviewSnapshot.data}');
      }
      return Center(
        child: Container(child: CircularProgressIndicator()),
      );
    },
  );
}

void displayCreateReviewCard(ctxt, token, userId, userName) => showDialog(
    context: ctxt,
    builder: (ctxt) => AlertDialog(
          content: CreateReview(
            token: token,
            clientOrAgentId: userId,
            name: userName
          ),
        ));

//only runs if the status of the job is marked complete
Future createReview(String token, bool userIsClient, int clientId, int agentId,
    int jobId) async {
  //checks to see if there are reviews for this task.
  //if user is client, checks review table for this jobId as well as agentId
  //if it doesnt exist then client hasn't reviewed agent. remind them. Else

  final String url = "$kBaseUrl/v1/reviews/$jobId/$userIsClient";

  final response = await http.get(Uri.encodeFull(url), headers: {
    "accept": "application/json",
    "content-type": "application/json",
    "x-auth-token": "$token",
  });

  if (response.statusCode == 200) {}
}
