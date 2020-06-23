import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/material_text.dart';
import 'package:servio/components/review_card.dart';
import 'package:servio/components/my_vertical_divider.dart';
import 'package:servio/components/icon_button_text.dart';

class ProfileScreen extends StatelessWidget {
  static String id = 'profile';
  final companyIsVerified = true;

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
                  background: Image.asset(
                    "images/business_woman.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  kExampleNameFemale,
                  style: kAppBarTitle.copyWith(color: Colors.white),
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
              Padding(
                padding: const EdgeInsets.all(kMainHorizontalPadding),
                child: Card(
                    elevation: kElevationValue/2,
                    child: Padding(
                      padding: const EdgeInsets.all(kMainHorizontalPadding),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Bio',
                            style: kHeadingTextStyle,
                          ),
                          Text(
                            kLoremIpsum,
                            style: kMainBlackTextStyle,
                          ),
                        ],
                      ),
                    ),),
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
                          kExampleEmail,
                          style: kHeadingSubTextStyle,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          kExamplePhone,
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
                                text: kAgent,
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
                                text: kClient,
                                color: Colors.grey.shade700,
                                fontStyle: kHeadingTextStyle.copyWith(
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        Row(),
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
              //BRIEF STATS
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
                          text: 'My Bids',
                          icon: Icons.attach_money,
                          materialColor: kMyBidsColor,
                        ),
                        IconButtonWithText(
                          text: 'My Jobs',
                          icon: Icons.work,
                          materialColor: kMyJobsColor,
                        ),
                        IconButtonWithText(
                          text: 'Settings',
                          icon: Icons.settings,
                          materialColor: kMySettingsColor,
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
              //OTHER ACTIONS
            ],
          ),
        ),
      ),
    );
  }
}