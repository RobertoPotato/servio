import 'package:flutter/material.dart';
import 'package:servio/components/icon_button_text.dart';
import 'package:servio/components/review_card.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/material_text.dart';
import 'package:servio/components/card_title_text.dart';
import 'package:servio/components/my_vertical_divider.dart';

class BidDetails extends StatefulWidget {
  static String id = 'bid_detail';

  @override
  _BidDetailsState createState() => _BidDetailsState();
}

class _BidDetailsState extends State<BidDetails> {
  var companyIsVerified = true;

  var isFavorite = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 370.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    'Bidder: $kExampleNameFemale',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  background: Image.asset(
                    "images/business_woman.jpg",
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
                padding: const EdgeInsets.symmetric(horizontal: kMainHorizontalPadding),
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
                      text: kExampleBidPrice,
                      color: kMyBidsColor,
                      fontStyle: kTestTextStyleWhite,
                    ),
                  ],
                ),
              ),

              //BIDDER'S PROPOSAL
              CardWithTitleAndText(
                title: 'Proposal',
                text: kLoremIpsum,
              ),

              //BIDDER'S STATS
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kMainHorizontalPadding,),
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
                              color:
                                  companyIsVerified ? Colors.blue : Colors.grey,
                              size: 28.0,
                            ),
                            Text(companyIsVerified
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
                    horizontal: kMainHorizontalPadding, vertical: kMainHorizontalPadding/2),
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
        ),
      ),
    );
  }
}
