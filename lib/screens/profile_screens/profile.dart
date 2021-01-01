import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/material_text.dart';
import 'package:servio/components/divider_component.dart';
import 'package:servio/components/icon_button_text.dart';
import 'package:servio/components/card_title_text.dart';
import 'package:servio/models/ReviewWithUser.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:servio/components/StatsWidget.dart';
import 'package:servio/screens/auth_screens/login_screen.dart';
import 'package:servio/screens/bids_screens/bids.dart';
import '../job_screens/job_parent_screen.dart';
import 'package:servio/screens/profile_screens/new_profile.dart';
import 'package:servio/jwt_helpers.dart';
import 'package:servio/components/image_container.dart';
import 'package:servio/components/review_card.dart';
import 'package:servio/screens/settings_screen.dart';
import 'package:servio/models/ProfileWithTierRoleAndUser.dart';
import 'package:servio/screens/image_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String token;
  const ProfileScreen({@required this.token});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final companyIsVerified = true;
  Future<ProfileWithTierRoleAndUser> futureProfile;
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
    var url = "$kBaseUrl/v1/reviews/foruser";

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

  Future<ProfileWithTierRoleAndUser> fetchProfile() async {
    var url = "$kBaseUrl/v1/profiles/withName";

    final response = await http.get(Uri.encodeFull(url),
        headers: {"Accept": "application/json", "x-auth-token": widget.token});

    final jsonResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      return ProfileWithTierRoleAndUser.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load Profile With Tier and Roles');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: FutureBuilder<ProfileWithTierRoleAndUser>(
        future: futureProfile,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(
                "${snapshot.data.user.firstName} ${snapshot.data.user.lastName}"
                    .toUpperCase());
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  //Navigate to the image screen on click
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => ImageScreen(
                              imageUrl:
                                  "$kImageBaseUrl${snapshot.data.picture}",
                              isNetworkImage: true),
                        ),
                      );
                    },
                    child: ImageContainer(
                      elevation: 5.0,
                      isNetworkImage: true,
                      borderRadius: 20.0,
                      height: 400.0,
                      bottomLeftRad: 20.0,
                      bottomRightRad: 20.0,
                      imageUrl: "$kImageBaseUrl${snapshot.data.picture}",
                    ),
                  ), //Picture
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: kMainHorizontalPadding,
                        left: kMainHorizontalPadding,
                        right: kMainHorizontalPadding),
                    child: Center(
                      child: Text(
                        "${snapshot.data.user.firstName} ${snapshot.data.user.lastName}",
                        style: kHeadingSubTextStyle,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: kMainHorizontalPadding,
                        right: kMainHorizontalPadding,
                        top: kMainHorizontalPadding),
                    child: CardWithTitleAndText(
                      title: 'Bio',
                      text: snapshot.data.bio,
                    ),
                  ), //Bio
                ),
                SliverToBoxAdapter(
                  child: Padding(
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  child: MaterialText(
                                    text: snapshot.data.role.title,
                                    color: kPrimaryColor,
                                    fontStyle: kHeadingTextStyle.copyWith(
                                        color: Colors.white),
                                  ),
                                ),
                                DividerComponent(
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
                  ), //Contacts row and tiers
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kMainHorizontalPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Recent reviews',
                          style: kHeadingTextStyle,
                        ),
                        Text(
                          'See All',
                          style: kHeadingSubTextStyle,
                        ),
                      ],
                    ),
                  ), //Reviews header
                ),
                reviews == null
                    ? SliverToBoxAdapter(
                        child: MaterialText(
                          text: "No reviews to show",
                          color: Colors.white,
                          fontStyle: kHeadingTextStyle,
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (context, index) => ReviewCard(
                                  rating: reviews[index]["stars"].toString(),
                                  review: reviews[index]["content"],
                                  reviewerName:
                                      "${reviews[index]['User']['firstName']} ${reviews[index]['User']['lastName']}",
                                ),
                            childCount: reviews == null ? 0 : reviews.length),
                      ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kMainHorizontalPadding,
                        vertical: kMainHorizontalPadding / 2),
                    child: StatsWidget(
                      successrate: kPercentage.toDouble(),
                      rating: kExampleRatingText,
                      isVerified: snapshot.data.isVerified,
                    ),
                  ), //Stats widget
                ),
                SliverToBoxAdapter(
                  child: Padding(
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
                                      token: widget.token,
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
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        JobParentScreen(
                                      token: widget.token,
                                    ),
                                  ),
                                );
                              },
                            ),
                            IconButtonWithText(
                              text: 'Settings',
                              icon: Icons.settings,
                              materialColor: kMySettingsColor,
                              onTap: () {
                                Navigator.pushNamed(context, SettingsScreen.id);
                              },
                            ),
                            IconButtonWithText(
                              text: 'Log Out',
                              icon: Icons.lock,
                              materialColor: kRedAlert,
                              onTap: () {
                                logOutUser(context, LoginScreen.id);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ), //Row with buttons
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("images/undraw_page_not_found.png"),
                  Text(
                    "We can't seem to find a profile associated with your account",
                    style: kTestTextStyleBlack,
                  ),
                  FlatButton(
                    color: kRedAlert,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => NewProfile(),
                        ),
                      );
                    },
                    child: Text(
                      "Create Profile",
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
      )),
    );
  }
}
