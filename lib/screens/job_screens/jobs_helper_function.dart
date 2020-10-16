import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:servio/models/Review.dart';
import 'package:servio/components/review_card.dart';
import 'package:servio/models/ErrorResponse.dart';
import 'package:servio/components/create_review.dart';
import 'package:servio/components/response_card.dart';

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
  } else if (response.statusCode == 400) {
    var error = Error.fromJson(json.decode(response.body));
    return error;
  } else {
    throw Exception("Couldn't fetch review");
  }
}

//return a widget that shows a review if available or a button telling you to
//leave a review if not, or an error if we couldn't fetch the review
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
        return reviewSnapshot.data.toString().trim() == "No review"
            ? Container(
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
              )
            : ReviewCard(
                rating: reviewSnapshot.data.stars,
                review: reviewSnapshot.data.content,
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

//print("seeReviewOrError token: $token");
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
