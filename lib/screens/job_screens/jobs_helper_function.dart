import 'package:flutter/material.dart';
import 'package:servio/components/material_text.dart';
import 'package:servio/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:servio/models/Review.dart';
import 'package:servio/components/review_card.dart';
import 'package:servio/models/ErrorResponse.dart';
import 'package:servio/components/create_review.dart';

//================ALERT!!!!======================
// These errors are sent from the server as is...
// If changed on server, change here as well
const SERVER_NO_REVIEW_ERROR =
    "No review"; //if the job is complete, show review reminder
const SERVER_JOB_NOT_FOUND_ERROR = "Job not found"; //fatal error, job not found
const SERVER_INSUFFICIENT_PERMISSIONS_ERROR =
    "Insufficient permissions"; //show invalid token


//get a review or none
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
  } else if (response.statusCode == 400) {
    var error = Error.fromJson(json.decode(response.body));
    return error.error;
  } else {
    return 'ERROR';
  }
}

//return a widget that shows a review if available or a button telling you to
//leave a review if not, or an error if we couldn't fetch the review
//process review to show its content or an error message
Widget seeReviewOrError(
    {@required futureReview,
    @required ctxt,
    @required token,
    @required userName,
    @required jobId,
    @required bool userIsClient}) {
  return FutureBuilder(
    future: futureReview,
    builder: (ctxt, reviewSnapshot) {
      if (reviewSnapshot.hasData) {
        var data = reviewSnapshot.data.toString().trim();
        if (data == SERVER_JOB_NOT_FOUND_ERROR) {
          return MaterialText(
            text:
                'Fatal error: \n($SERVER_JOB_NOT_FOUND_ERROR): when looking for review',
            color: kRedAlert,
            fontStyle: kTestTextStyleWhite,
          );
        } else if(data == SERVER_INSUFFICIENT_PERMISSIONS_ERROR){
          return MaterialText(
            text:
            'Fatal error: \n($SERVER_INSUFFICIENT_PERMISSIONS_ERROR) when looking for review',
            color: kRedAlert,
            fontStyle: kTestTextStyleWhite,
          );
        } else if(data == SERVER_NO_REVIEW_ERROR){
          return Container(
            child: FlatButton(
              color: kPrimaryColor,
              onPressed: () {
                displayCreateReviewCard(
                    userIsClient: userIsClient,
                    ctxt: ctxt,
                    token: token,
                    userName: userName,
                    jobId: jobId);
                print("Show popup that lets user write a review");
              },
              child: Text(
                "Write a review",
                style: kTestTextStyleWhite,
              ),
            ),
          );
        } else {
          return ReviewCard(
            rating: reviewSnapshot.data.stars.toString(),
            review: reviewSnapshot.data.content,
            reviewerName: "By me",
          );
        }
      } else if (reviewSnapshot.hasError) {
        return Text('Failed to load review: ${reviewSnapshot.error}');
      }
      return Center(
        child: Container(child: CircularProgressIndicator()),
      );
    },
  );
}

//show the modal that lets users create a review
void displayCreateReviewCard(
        {@required ctxt,
        @required token,
        @required userName,
        @required jobId,
        @required bool userIsClient}) =>
    showDialog(
      context: ctxt,
      builder: (ctxt) => AlertDialog(
        content: CreateReview(
          userIsClient: userIsClient,
          token: token,
          name: userName,
          jobId: jobId,
        ),
      ),
    );
