import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/material_text.dart';
import 'package:servio/components/card_title_text.dart';
import 'package:servio/components/grid_details_card.dart';
import 'package:servio/components/icon_button_text.dart';
import 'package:servio/models/ProfileWithTierAndRole.dart';
import 'package:servio/screens/bids_screens/make_bid_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:servio/screens/profile_screens/profile_user.dart';
import 'package:servio/components/image_container.dart';

class ServiceDetails extends StatefulWidget {
  final userId;
  final serviceId;
  final categoryTitle;
  final title;
  final description;
  final budget;
  final terms;
  final imageUrl;
  final county;
  final town;
  final firstName;
  final lastName;

  ServiceDetails({
    this.userId,
    this.serviceId,
    this.categoryTitle,
    this.title,
    this.description,
    this.budget,
    this.terms,
    this.imageUrl,
    this.county,
    this.town,
    this.firstName,
    this.lastName,
  });

  @override
  _ServiceDetailsState createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  Future<ProfileWithTierAndRole> futureProfile;
  List profile;

  @override
  void initState() {
    super.initState();
    futureProfile = fetchProfile();
  }

  //TODO Make it necessary to log in to view a user's profile
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
        appBar: AppBar(
          title: Text('Category: ${widget.categoryTitle}'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ImageContainer(
                imageUrl: "$kImageBaseUrl${widget.imageUrl}",
                height: 400.0,
                borderRadius: 20.0,
                bottomRightRad: 20.0,
                bottomLeftRad: 20.0,
                isNetworkImage: true,
                elevation: kElevationValue / 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kMainHorizontalPadding + 5,
                    vertical: kMainHorizontalPadding / 2),
                child: MaterialText(
                  text: "Title: ${widget.title}", //title
                  fontStyle: kMainBlackTextStyle,
                ),
              ),
              CardWithTitleAndText(
                title: 'Description',
                text: '${widget.description}',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kMainHorizontalPadding,
                    vertical: kMainHorizontalPadding / 2),
                child: GridDetailsCard(
                  row1col1: "${widget.county} County",
                  row1col2: "${widget.town} Town",
                  row2col1: "Ksh: ${widget.budget}",
                  row2col2: widget.terms,
                ),
              ),
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
                          text: 'Bid',
                          icon: Icons.sentiment_very_satisfied,
                          materialColor: kMyBidsColor,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MakeBidScreen(
                                  budgetRange: widget.budget,
                                  serviceId: widget.serviceId,
                                  serviceCategory: "${widget.categoryTitle}",
                                  serviceTitle: "${widget.title}",
                                ),
                              ),
                            );
                          },
                        ),
                        IconButtonWithText(
                          onTap: () {
                            showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return FutureBuilder(
                                    future: futureProfile,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data != "") {
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(30.0),
                                                topRight: Radius.circular(30.0),
                                              ),
                                            ),
                                            child: UserProfile(
                                              userName:
                                                  "${widget.firstName} ${widget.lastName}",
                                              avatar: snapshot.data.avatar,
                                              roleTitle:
                                                  snapshot.data.role.title,
                                              roleDescription: snapshot
                                                  .data.role.description,
                                              updatedAt: snapshot.data.updatedAt
                                                  .toIso8601String(),
                                              isVerified:
                                                  snapshot.data.isVerified,
                                              picture: snapshot.data.picture,
                                              bio: snapshot.data.bio,
                                              tierTitle:
                                                  snapshot.data.tier.title,
                                              tierDescription: snapshot
                                                  .data.tier.description,
                                              tierBadgeUrl:
                                                  snapshot.data.tier.badgeUrl,
                                              phoneNumber:
                                                  snapshot.data.phoneNumber,
                                            ),
                                          );
                                        }
                                      }
                                      return Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.face,
                                              size: 54.0,
                                              color: Colors.grey[700],
                                            ),
                                            Text(
                                                "Can\'t find the user's profile information"),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                });
                          },
                          text: 'Profile',
                          icon: Icons.person,
                          materialColor: kMyJobsColor,
                        ),
                        IconButtonWithText(
                          text: 'Close',
                          icon: Icons.not_interested,
                          materialColor: kRedAlert,
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
