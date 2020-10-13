import 'package:flutter/material.dart';
import 'package:servio/components/icon_button_text.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/card_title_text.dart';
import 'package:servio/components/material_text.dart';
import 'package:servio/date_time.dart';
import 'package:servio/models/ProfileWithTierAndRole.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:servio/screens/profile_screens/profile_user.dart';
import 'package:servio/jwt_helpers.dart';
import 'package:servio/models/ErrorResponse.dart';
import 'jobs_helper_function.dart';

class JobDetails extends StatefulWidget {
  final client;
  final agent;
  final bid;
  final service;
  final status;
  final jobStart;
  final bool userIsClient;
  final int jobId;
  final int clientId;
  final int agentId;
  final String token;

  const JobDetails(
      {@required this.client,
      @required this.agent,
      @required this.bid,
      @required this.service,
      @required this.status,
      @required this.jobStart,
      //checks if the info coming is from the role of the current user being the client
      @required this.userIsClient,
      @required this.jobId,
      @required this.clientId,
      @required this.agentId,
      @required this.token});

  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  /*
     if user is client, fetch part of the agent's profile and store it to be used
     in the popup banner and if user is agent then fetch the client's profile instead.
     all we do is use different URLs for each case
  * */
  int userId(bool userIsClient) {
    if (userIsClient) {
      return widget.agentId;
    } else {
      return widget.clientId;
    }
  }

  Future<ProfileWithTierAndRole> futureProfile;
  Future futureReviewOrEmpty;
  List profile;
  bool showSpinner = true;
  bool showReviewModal = false;

  @override
  void initState() {
    super.initState();
    futureProfile = fetchProfile();
    futureReviewOrEmpty = fetchReviewOrEmpty(widget.token, widget.jobId);
  }

  Future<String> _markJobDone(int statusId, ctxt) async {
    var url = "$kBaseUrl/v1/jobs/${widget.jobId}/done";

    final response = await http.put(Uri.encodeFull(url),
        body: json.encode({
          "statusId": statusId,
        }),
        headers: {
          "accept": "application/json",
          "content-type": "application/json",
          "x-auth-token": widget.token
        });

    if (response.statusCode == 200) {
      setState(() {
        //TODO Show review prompt showReviewModal = true;
      });
      displayResponseCard(
          ctxt, 'Success', "Job has been marked as DONE", kSuccessImage);
      return "Job has been marked DONE";
    } else if (response.statusCode == 400) {
      var error = errorFromJson(response.body);
      displayResponseCard(ctxt, "Oops!", error.error, kErrorImage);
      return error.error;
    } else {
      displayResponseCard(ctxt, "Oops!", kSomethingWrongException, kErrorImage);
      return kSomethingWrongException;
    }
  }

  Future<String> _markJobComplete(int statusId, ctxt) async {
    //post change to the url specified based on the job id an agentId
    var url = "$kBaseUrl/v1/jobs/${widget.jobId}/complete";

    final response = await http.put(Uri.encodeFull(url),
        body: json.encode({
          "statusId": statusId,
        }),
        headers: {
          "accept": "application/json",
          "content-type": "application/json",
          "x-auth-token": widget.token
        });

    if (response.statusCode == 200) {
      displayResponseCard(
          ctxt, 'Success', "Job has been marked COMPLETE", kSuccessImage);
      return "Job has been marked COMPLETE";
    } else if (response.statusCode == 400) {
      var error = errorFromJson(response.body);
      displayResponseCard(ctxt, 'Oops!', error.error, kErrorImage);
      return error.error;
    } else {
      displayResponseCard(ctxt, "Oops!", kSomethingWrongException, kErrorImage);
      return kSomethingWrongException;
    }
  }

  Future<ProfileWithTierAndRole> fetchProfile() async {
    var url = "$kBaseUrl/v1/profiles/${userId(widget.userIsClient)}";

    final response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    final jsonResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        showSpinner = false;
      });
      return ProfileWithTierAndRole.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load Profile With Tier and Roles');
    }
  }

  @override
  Widget build(BuildContext context) {
    _showSnack(BuildContext context, text) {
      final snackBar = SnackBar(
        content: Text(text),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }

    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 370.0,
                floating: false,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: Image.network(
                    "$kImageBaseUrl${widget.service['imageUrl']}",
                    fit: BoxFit.cover,
                  ),
                ),
                title: InkWell(
                  onTap: () {
                    _showSnack(context, widget.status["description"]);
                  },
                  child: Text(
                    "Job Status: ${widget.status["title"]}",
                    style: kAppBarTitle.copyWith(
                        color: Colors.white, fontSize: 24.0),
                  ),
                ),
              )
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kMainHorizontalPadding,
                      vertical: kMainHorizontalPadding / 3),
                  child: MaterialText(
                    text: "${widget.service["title"]}",
                    fontStyle: kTestTextStyleWhite,
                    color: kPrimaryColor,
                  ),
                ),
                CardWithTitleAndText(
                  title: "Project Description",
                  text: "${widget.service["description"]}",
                ),
                //Show the terms of the job and when the job was created
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kMainHorizontalPadding,
                      vertical: kMainHorizontalPadding / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialText(
                        text: "${widget.service["terms"]}",
                        fontStyle: kTestTextStyleWhite,
                        color: kMyJobsColor,
                      ),
                      Flexible(
                          child: Text(
                        parseDate(widget.service["createdAt"]),
                        style: kTestTextStyleBlack,
                        maxLines: 4,
                        overflow: TextOverflow.fade,
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(kMainHorizontalPadding),
                  child: Container(
                    child: widget.userIsClient
                        ? CardWithTitleAndText(
                            title: 'Winning Bid: ${widget.bid['amount']}',
                            text:
                                "${widget.bid['coverLetter']}. \nAgent's availability is: ${widget.bid['availability']}",
                          )
                        : MaterialText(
                            text: "Started on: ${parseDate(widget.jobStart)}",
                            color: kPrimaryColor,
                            fontStyle: kHeadingSubTextStyle.copyWith(
                                color: Colors.white),
                          ),
                  ),
                ),
                showSpinner
                    ? MaterialText(
                        text: "Looking for user\'s profile",
                        fontStyle: kTestTextStyleWhite,
                        color: kPrimaryColor,
                      )
                    : FutureBuilder<ProfileWithTierAndRole>(
                        future: futureProfile,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return UserProfile(
                              userName: widget.userIsClient
                                  ? "${widget.agent['firstName']} ${widget.agent['lastName']}"
                                  : "${widget.client['firstName']} ${widget.client['lastName']}",
                              avatar: snapshot.data.avatar,
                              roleTitle: snapshot.data.role.title,
                              roleDescription: snapshot.data.role.description,
                              updatedAt: parseDate(
                                  snapshot.data.updatedAt.toIso8601String()),
                              isVerified: snapshot.data.isVerified,
                              picture: "$kImageBaseUrl${snapshot.data.picture}",
                              bio: snapshot.data.bio,
                              tierTitle: snapshot.data.tier.title,
                              tierDescription: snapshot.data.tier.description,
                              tierBadgeUrl: snapshot.data.tier.badgeUrl,
                              phoneNumber: snapshot.data.phoneNumber,
                            );
                          } else if (snapshot.hasError) {
                            return Text('Failed to load profile');
                          }
                          return Center(
                            child:
                                Container(child: CircularProgressIndicator()),
                          );
                        },
                      ),
                seeReviewOrError(futureReviewOrEmpty, context, widget.token, widget.agentId),
                Padding(
                  padding: EdgeInsets.all(kMainHorizontalPadding),
                  child: widget.userIsClient
                      //we are setting a static statusID for testing purposes only
                      ? IconButtonWithText(
                          onTap: () async {
                            //Changes the status of the job to completed thus ending it.
                            //TODO Switch to the actual intended status ID
                            await _markJobComplete(2, context);
                          },
                          text: 'Close',
                          icon: Icons.thumb_up,
                          materialColor: kAccentColor,
                        )
                      : IconButtonWithText(
                          onTap: () async {
                            //changes the status of the job to completed requesting client's input
                            //TODO Switch to the actual intended status ID
                            await _markJobDone(4, context);
                          },
                          text: 'Done',
                          icon: Icons.done,
                          materialColor: kAccentColor,
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
