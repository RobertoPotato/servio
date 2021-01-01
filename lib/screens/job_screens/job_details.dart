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
import 'package:servio/components/image_container.dart';
import 'package:servio/components/grid_details_card.dart';
import 'package:servio/screens/image_screen.dart';
import 'package:servio/components/details_container.dart';
import 'package:servio/components/sections_separator.dart';
import 'package:servio/components/divider_component.dart';

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
      @required this.userIsClient,
      @required this.jobId,
      @required this.clientId,
      @required this.agentId,
      @required this.token});

  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
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

  Future<String> _markJobDone(ctxt) async {
    var url = "$kBaseUrl/v1/jobs/${widget.jobId}/done";

    final response = await http.put(Uri.encodeFull(url), headers: {
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
      displayResponseCard(ctxt, kUniversalErrorTitle, error.error, kErrorImage);
      return error.error;
    } else {
      displayResponseCard(
          ctxt, kUniversalErrorTitle, kSomethingWrongException, kErrorImage);
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
    print(
        "Agent last: ${widget.agent['lastName']} Client first: ${widget.client['firstName']}");

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Job Status: ${widget.status["title"]}",
            style: kAppBarTitle.copyWith(color: Colors.white, fontSize: 24.0),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ImageScreen(
                          imageUrl:
                              "$kImageBaseUrl${widget.service['imageUrl']}",
                          isNetworkImage: true),
                    ),
                  );
                },
                child: ImageContainer(
                  imageUrl: "$kImageBaseUrl${widget.service['imageUrl']}",
                  height: 400.0,
                  borderRadius: 20.0,
                  bottomLeftRad: 20.0,
                  bottomRightRad: 20.0,
                  isNetworkImage: true,
                  elevation: kElevationValue / 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kMainHorizontalPadding),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: kMainHorizontalPadding / 2),
                      child: MaterialText(
                        text:
                            "${widget.service["title"].toString().toUpperCase()}",
                        fontStyle: kTestTextStyleWhite,
                        color: kPrimaryColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: kMainHorizontalPadding / 2),
                      child: DetailsContainer(
                          title: "Project Description",
                          content: "${widget.service["description"]}"),
                    ),
                    //Show the terms of the job and when the job was created
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: kMainHorizontalPadding / 2),
                      child: GridDetailsCard(
                          row1col1: 'Terms',
                          row1col2: "${widget.service["terms"]}",
                          row2col1: "Bid amount",
                          row2col2: "${widget.bid['amount']}"),
                    ),

                    widget.userIsClient
                        ?
                        //Client sees this
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: kMainHorizontalPadding / 2),
                            child: GridDetailsCard(
                                row1col1: "Availability",
                                row1col2: "${widget.bid['availability']}",
                                row2col1: "Start Date",
                                row2col2:
                                    "${parseDate(widget.service["createdAt"])}"),
                          )
                        :
                        //Agent sees this
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: kMainHorizontalPadding / 2),
                            child: MaterialText(
                              text: "Started on: ${parseDate(widget.jobStart)}",
                              color: kPrimaryColor,
                              fontStyle: kHeadingSubTextStyle.copyWith(
                                  color: Colors.white),
                            ),
                          ),
                    DetailsContainer(
                        title: "Cover Letter",
                        content: "${widget.bid['coverLetter']}"),

                    SectionsSeparator(
                        text: widget.userIsClient
                            ? "Agent's Profile"
                            : "Client's Profile"),
                  ],
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
                          child: Container(child: CircularProgressIndicator()),
                        );
                      },
                    ),

              SectionsSeparator(
                  text: "Actions"),
              seeReviewOrError(
                  userIsClient: widget.userIsClient,
                  futureReview: futureReviewOrEmpty,
                  ctxt: context,
                  token: widget.token,
                  jobId: widget.jobId,
                  userName: widget.userIsClient
                      ? "${widget.agent['firstName']} ${widget.agent['lastName']}"
                      : "${widget.client['firstName']} ${widget.client['lastName']}"),
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
                          await _markJobDone(context);
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
    );
  }
}
