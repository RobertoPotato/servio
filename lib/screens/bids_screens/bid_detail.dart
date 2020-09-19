import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servio/components/icon_button_text.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/material_text.dart';
import 'package:servio/components/card_title_text.dart';
import 'package:http/http.dart' as http;
import 'package:servio/models/ProfileWithTierAndRole.dart';
import 'package:servio/models/ReviewWithUser.dart';
import 'dart:convert';
import 'package:servio/screens/profile_screens/profile_user.dart';
import 'package:servio/screens/errors/error_screen.dart';
import 'package:servio/components/list_of_reviews.dart';
import 'package:servio/screens/bids_screens/create_job.dart';
import 'package:servio/components/StatsWidget.dart';

class BidDetails extends StatefulWidget {
  //TODO will get userId later from sharedpreferences. For now, use a static id

  final double amount;
  final String coverLetter;
  final bool canTravel;
  final String availability;
  final String currency;
  //this is the agent's id. Client's ID will be loaded from SP
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
  //TODO use setState to change state of the favorite icon depending on whether or not its marked as a favorite bid
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
    var url = "$kBaseUrl/v1/reviews/foruser/${widget.userId}";

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
    _showSnack(BuildContext context, String text) {
      final snackBar = SnackBar(
        content: Text(text),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<ProfileWithTierAndRole>(
          future: futureProfile,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      expandedHeight: 370.0,
                      floating: false,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Text(
                          widget.userName,
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                        //TODO change placeholder image to show when getting actual image from the network
                        background: FadeInImage.assetNetwork(
                          placeholder: "images/business_woman.jpg",
                          image: snapshot.data.picture,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ];
                },
                body: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kMainHorizontalPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          isFavorite
                              ? Icon(
                                  Icons.favorite,
                                  color: kRedAlert,
                                  size: 30.0,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  size: 30.0,
                                ),
                          MaterialText(
                            text: "${widget.currency} ${widget.amount}",
                            color: kMyBidsColor,
                            fontStyle: kTestTextStyleWhite,
                          ),
                        ],
                      ),
                    ),

                    //BIDDER'S PROPOSAL
                    CardWithTitleAndText(
                      title: 'Cover Letter',
                      text: widget.coverLetter,
                    ),

                    //BIDDER'S STATS
                    StatsWidget(
                      rating: kExampleRatingText,
                      isVerified: snapshot.data.isVerified,
                      successrate: 99,
                    ),

                    //FEW REVIEWS
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kMainHorizontalPadding),
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
                    reviews.length == 0 || reviews.length == null
                        ? Center(
                            child: MaterialText(
                              text: "No reviews to show",
                              color: Colors.white,
                              fontStyle: kHeadingTextStyle,
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
                                    var acceptUserBid = await acceptBid(
                                      MJob(

                                          widget.token,
                                          widget.userId,
                                          widget.bidId,
                                          widget.serviceId,
                                          kStatusId),
                                    );

                                    _showSnack(context, acceptUserBid);
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                              ),
                              IconButtonWithText(
                                onTap: () {
                                  showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30.0),
                                              topRight: Radius.circular(30.0),
                                            ),
                                          ),
                                          child: UserProfile(
                                            userName: widget.userName,
                                            avatar: snapshot.data.avatar,
                                            roleTitle: snapshot.data.role.title,
                                            roleDescription:
                                                snapshot.data.role.description,
                                            updatedAt: snapshot.data.updatedAt
                                                .toIso8601String(),
                                            isVerified:
                                                snapshot.data.isVerified,
                                            picture: snapshot.data.picture,
                                            bio: snapshot.data.bio,
                                            tierTitle: snapshot.data.tier.title,
                                            tierDescription:
                                                snapshot.data.tier.description,
                                            tierBadgeUrl:
                                                snapshot.data.tier.badgeUrl,
                                            phoneNumber:
                                                snapshot.data.phoneNumber,
                                          ),
                                        );
                                      });
                                },
                                text: 'Profile',
                                icon: Icons.person,
                                materialColor: kMyJobsColor,
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
                ),
              );
            } else if (snapshot.hasError) {
              return ErrorScreen(
                message: "Unable to find what you're looking for. REASONS:\n${snapshot.error}",
                errorImage: kPageNotFoundImage,
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
