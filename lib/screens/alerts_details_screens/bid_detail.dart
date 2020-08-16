import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servio/components/icon_button_text.dart';
import 'package:servio/components/review_card.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/material_text.dart';
import 'package:servio/components/card_title_text.dart';
import 'package:servio/components/my_vertical_divider.dart';
import 'package:http/http.dart' as http;
import 'package:servio/models/ProfileWithTierAndRole.dart';
import 'dart:convert';
import 'package:servio/screens/profile_user.dart';

class BidDetails extends StatefulWidget {
  final double amount;
  final String coverLetter;
  final bool canTravel;
  final String availability;
  final String currency;
  final int userId;
  final String updatedAt;
  final String userName;

  const BidDetails(
      {@required this.amount,
      @required this.coverLetter,
      @required this.canTravel,
      @required this.availability,
      @required this.currency,
      @required this.userId,
      @required this.updatedAt,
      @required this.userName});

  @override
  _BidDetailsState createState() => _BidDetailsState();
}

class _BidDetailsState extends State<BidDetails> {
  var companyIsVerified = true;
  //TODO use setState to change state of the favorite icon depending on whether or not its marked as a favorite bid
  var isFavorite = false;

  Future<ProfileWithTierAndRole> futureProfile;
  List profile;

  @override
  void initState() {
    super.initState();
    futureProfile = fetchProfile();
  }

  Future<ProfileWithTierAndRole> fetchProfile() async {
    var url = "$kBaseUrl/v1/profiles/${widget.userId}";

    final response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    final jsonResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      //print("DATA ==> ${ProfileWithTierAndRole.fromJson(jsonResponse)}");
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kMainHorizontalPadding,
                      ),
                      child: Card(
                        elevation: kElevationValue / 2,
                        child: Padding(
                          padding: const EdgeInsets.all(kMainHorizontalPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(kExampleRatingText.toString()),
                                  Text('Rating')
                                ],
                              ),
                              MyVerticalDivider(
                                height: 28.0,
                                width: 1.0,
                                color: kPrimaryColor,
                              ),
                              Column(
                                children: <Widget>[
                                  Text('${kPercentage.toString()}%'),
                                  Text('Success rate')
                                ],
                              ),
                              MyVerticalDivider(
                                height: 28.0,
                                width: 1.0,
                                color: kPrimaryColor,
                              ),
                              Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.verified_user,
                                    color: snapshot.data.isVerified
                                        ? Colors.blue
                                        : Colors.grey,
                                    size: 28.0,
                                  ),
                                  Text(snapshot.data.isVerified
                                      ? 'Verified'
                                      : 'Not Verified'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    //FEW REVIEWS
                    Container(
                      height: 160.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          ReviewCard(
                            reviewerName: 'John Doe',
                            review: kLoremIpsum,
                            reviewerAvatar: 'owl.png',
                            rating: 4.5,
                          ),
                          ReviewCard(
                            reviewerName: 'Jane Doe',
                            review: kLoremIpsumShort,
                            reviewerAvatar: 'owl.png',
                            rating: 2.0,
                          ),
                          ReviewCard(
                            reviewerName: 'Jack Doe',
                            review: kLoremIpsum,
                            reviewerAvatar: 'owl.png',
                            rating: 4.5,
                          ),
                          ReviewCard(
                            reviewerName: 'Joan Doe',
                            review: kLoremIpsumShort,
                            reviewerAvatar: 'owl.png',
                            rating: 4.5,
                          ),
                        ],
                      ),
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
              //TODO Maybe add a nice error graphic to display rather than throw the system error at the user
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("images/undraw_page_not_found.png"),
                    Text("Unable to find what you're looking for", style: kTestTextStyleBlack,),
                    FlatButton(
                      color: kRedAlert,
                      textColor: Colors.white,
                      onPressed: (){
                        Navigator.pop(context);
                      }, child: Text("Go Back", style: kTestTextStyleWhite,),
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
