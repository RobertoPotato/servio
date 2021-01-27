import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servio/components/icon_button_text.dart';
import 'package:servio/components/divider_component.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/material_text.dart';
import 'package:servio/components/card_title_text.dart';
import 'package:http/http.dart' as http;
import 'package:servio/models/ProfileWithTierAndRole.dart';
import 'package:servio/models/ReviewWithUser.dart';
import 'dart:convert';
import 'package:servio/screens/errors/error_screen.dart';
import 'package:servio/components/list_of_reviews.dart';
import 'package:servio/screens/bids_screens/create_job.dart';
import 'package:servio/components/StatsWidget.dart';
import 'package:servio/components/image_container.dart';
import 'package:servio/screens/image_screen.dart';

class BidDetails extends StatefulWidget {
  final double amount;
  final String coverLetter;
  final bool canTravel;
  final String availability;
  final String currency;
  final int userId;
  final String updatedAt;
  final String userName;
  final int serviceId;
  final int bidId;
  final String token;

  const BidDetails(
      {@required this.amount,
      @required this.coverLetter,
      @required this.canTravel,
      @required this.availability,
      @required this.currency,
      @required this.userId,
      @required this.updatedAt,
      @required this.userName,
      @required this.serviceId,
      @required this.bidId,
      @required this.token});

  @override
  _BidDetailsState createState() => _BidDetailsState();
}

class _BidDetailsState extends State<BidDetails> {
  var companyIsVerified = true;
  var isFavorite = false;

  Future<ProfileWithTierAndRole> futureProfile;
  Future<ReviewWithUser> futureReviews;
  List profile;
  List reviews;

  @override
  void initState() {
    super.initState();
    futureProfile = fetchProfile();
    futureReviews = fetchReviews();
  }
  //TODO Setup a client to use here

  Future<ProfileWithTierAndRole> fetchProfile() async {
    var url = "$kBaseUrl/v1/profiles/${widget.userId}";

    final response = await http.get(Uri.encodeFull(url),
        headers: {"Accept": "application/json", "x-auth-token": widget.token});

    final jsonResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      return ProfileWithTierAndRole.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load Profile With Tier and Roles');
    }
  }

  Future<ReviewWithUser> fetchReviews() async {
    var url = "$kBaseUrl/v1/reviews/foruser/${widget.bidId}";
    print("Bid ID: $url");

    final response = await http.get(Uri.encodeFull(url),
        headers: {"Accept": "application/json", "x-auth-token": widget.token});

    final jsonResponse = json.decode(response.body);

    setState(() {
      reviews = json.decode(response.body);
    });

    if (response.statusCode == 200) {
      return ReviewWithUser.fromJson(jsonResponse[0]);
    } else {
      throw Exception('Failed to load Reviews with Users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<ProfileWithTierAndRole>(
          future: futureProfile,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: <Widget>[
                  InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => ImageScreen(
                              imageUrl: "$kImageBaseUrl${snapshot.data.picture}",
                              isNetworkImage: true),
                        ),
                      );
                    },
                    child: ImageContainer(
                      elevation: 0.0,
                      isNetworkImage: true,
                      borderRadius: 20.0,
                      bottomRightRad: 20.0,
                      bottomLeftRad: 20.0,
                      height: 350.0,
                      imageUrl: "$kImageBaseUrl${snapshot.data.picture}",
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kMainHorizontalPadding),
                      child: MaterialText(
                        text:
                            "${widget.userName.toUpperCase()}: ${widget.currency} ${widget.amount}",
                        color: kMyBidsColor,
                        fontStyle: kTestTextStyleWhite,
                      ),
                    ),
                  ),

                  //BIDDER'S PROPOSAL
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kMainHorizontalPadding,
                        vertical: kMainHorizontalPadding / 2),
                    child: CardWithTitleAndText(
                      title: 'Cover Letter',
                      text: widget.coverLetter,
                    ),
                  ),

                  //BIDDER'S STATS
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kMainHorizontalPadding,
                        vertical: kMainHorizontalPadding / 2),
                    child: StatsWidget(
                      rating: kExampleRatingText,
                      isVerified: snapshot.data.isVerified,
                      successrate: 99,
                    ),
                  ),
                  //More Stats
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kMainHorizontalPadding,
                        vertical: kMainHorizontalPadding / 2),
                    child: Card(
                      elevation: kElevationValue / 2,
                      child: Padding(
                        padding: const EdgeInsets.all(kMainHorizontalPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.supervisor_account,
                                      size: 28.0, color: Colors.greenAccent),
                                  Text("${snapshot.data.role.title}")
                                ],
                              ),
                            ),
                            DividerComponent(
                              height: 28.0,
                              width: 1.0,
                              color: kPrimaryColor,
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.star,
                                      size: 28.0, color: Colors.orangeAccent),
                                  Text('${snapshot.data.tier.title}')
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //User's Bio
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kMainHorizontalPadding,
                        vertical: kMainHorizontalPadding / 2),
                    child: CardWithTitleAndText(
                      title: "User\'s Bio",
                      text: "${snapshot.data.bio}",
                    ),
                  ),
                  //FEW REVIEWS
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kMainHorizontalPadding + 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Reviews',
                          style: kHeadingTextStyle,
                        ),
                        Text(
                          'See All',
                          style: kHeadingSubTextStyle,
                        ),
                      ],
                    ),
                  ),
                  //REVIEWS
                  reviews == null
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MaterialText(
                              text: "No reviews to show".toUpperCase(),
                              color: Colors.white,
                              fontStyle: kHeadingTextStyle,
                            ),
                          ),
                        )
                      : ListOfReviews(
                          reviews: reviews,
                        ),
                  //ACTIONS
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kMainHorizontalPadding,
                        vertical: kMainHorizontalPadding / 2),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButtonWithText(
                              text: 'Accept',
                              icon: Icons.sentiment_very_satisfied,
                              materialColor: kMyBidsColor,
                              onTap: () async {
                                try {
                                  await acceptBid(
                                      job: MJob(
                                          widget.token,
                                          widget.userId,
                                          widget.bidId,
                                          widget.serviceId,
                                          kStatusId),
                                      ctxt: context);
                                } catch (e) {
                                  print(e);
                                }
                              },
                            ),
                            IconButtonWithText(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              text: 'Decline',
                              icon: Icons.not_interested,
                              materialColor: kRedAlert,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return ErrorScreen(
                message:
                    "Unable to find what you're looking for. REASONS:\n${snapshot.error}",
                errorImage: kPageNotFoundImage,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
