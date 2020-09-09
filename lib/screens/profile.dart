import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/material_text.dart';
import 'package:servio/components/my_vertical_divider.dart';
import 'package:servio/components/icon_button_text.dart';
import 'package:servio/components/card_title_text.dart';
import 'package:servio/models/ProfileWithTierAndRole.dart';
import 'package:servio/models/ReviewWithUser.dart';
import 'package:servio/screens/settings_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:servio/components/StatsWidget.dart';
import 'package:servio/components/list_of_reviews.dart';
import 'package:servio/screens/bids_screens/bids.dart';

import 'job_screens/job_parent_screen.dart';

//TODO Use profileWithTierAndRole passing the logged in user id
class ProfileScreen extends StatefulWidget {
  final int userId;
  const ProfileScreen({@required this.userId});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final companyIsVerified = true;
  Future<ProfileWithTierAndRole> futureProfile;
  Future<ReviewWithUser> futureReviews;
  List reviews;
  List profile;

  @override
  void initState() {
    super.initState();
    futureProfile = fetchProfile();
    futureReviews = fetchReviews();
  }

  Future<ReviewWithUser> fetchReviews() async {
    var url = "$kBaseUrl/v1/reviews/foruser/${widget.userId}";

    final response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

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

  Future<ProfileWithTierAndRole> fetchProfile() async {
    var url = "$kBaseUrl/v1/profiles/${widget.userId}";

    final response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    final jsonResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      return ProfileWithTierAndRole.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load Profile With Tier and Roles');
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
                        background: Image.network(
                          snapshot.data.picture,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        "My Profile",
                        style: kAppBarTitle.copyWith(
                            color: Colors.white, fontSize: 24.0),
                      ),
                    )
                  ];
                },
                body: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    //BIO
                    CardWithTitleAndText(
                      title: 'Bio',
                      text: snapshot.data.bio,
                    ),
                    //CONTACTS
                    Padding(
                      padding: const EdgeInsets.all(kMainHorizontalPadding),
                      child: Card(
                        elevation: kElevationValue / 2,
                        child: Padding(
                          padding: const EdgeInsets.all(kMainHorizontalPadding),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'My Contacts',
                                style: kHeadingTextStyle,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                snapshot.data.phoneNumber,
                                style: kHeadingSubTextStyle,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              /*TODO make the roles user plays active and those not plaid inactive. Roles will be selected upon registration */
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    child: MaterialText(
                                      text: snapshot.data.role.title,
                                      color: kPrimaryColor,
                                      fontStyle: kHeadingTextStyle.copyWith(
                                          color: Colors.white),
                                    ),
                                  ),
                                  MyVerticalDivider(
                                    height: 20.0,
                                    width: 1.0,
                                    color: kPrimaryColor,
                                  ),
                                  Container(
                                    child: MaterialText(
                                      text: snapshot.data.tier.title,
                                      color: Colors.grey.shade700,
                                      fontStyle: kHeadingTextStyle.copyWith(
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
                    reviews.length == null || reviews.length == 0
                        ? Center(
                            child: MaterialText(
                            text: "No reviews to show",
                            color: Colors.white,
                            fontStyle: kHeadingTextStyle,
                          ))
                        : ListOfReviews(
                            reviews: reviews,
                          ),
                    //BRIEF STATS
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kMainHorizontalPadding,
                          vertical: kMainHorizontalPadding / 2),
                      child: StatsWidget(
                        successrate: kPercentage.toDouble(),
                        rating: kExampleRatingText,
                        isVerified: snapshot.data.isVerified,
                      ),
                    ),
                    //EXTRA OPTIONS
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kMainHorizontalPadding),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButtonWithText(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => Bids(
                                        userId: widget.userId,
                                      ),
                                    ),
                                  );
                                },
                                text: 'My Bids',
                                icon: Icons.attach_money,
                                materialColor: kMyBidsColor,
                              ),
                              IconButtonWithText(
                                text: 'My Jobs',
                                icon: Icons.work,
                                materialColor: kMyJobsColor,
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => JobParentScreen(),
                                    ),
                                  );
                                },
                              ),
                              IconButtonWithText(
                                text: 'Settings',
                                icon: Icons.settings,
                                materialColor: kMySettingsColor,
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, SettingsScreen.id);
                                },
                              ),
                              IconButtonWithText(
                                text: 'Log Out',
                                icon: Icons.lock,
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
              //TODO Maybe add a nice error graphic to display rather than throw the system error at the user
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("images/undraw_page_not_found.png"),
                    Text(
                      "Unable to find what you're looking for",
                      style: kTestTextStyleBlack,
                    ),
                    FlatButton(
                      color: kRedAlert,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Go Back",
                        style: kTestTextStyleWhite,
                      ),
                    )
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
