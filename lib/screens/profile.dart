import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/material_text.dart';
import 'package:servio/components/review_card.dart';

class ProfileScreen extends StatelessWidget {
  static String id = 'profile';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 320.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    kExampleNameFemale,
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  background: Image.asset("images/business_woman.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ];
          },
          body: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(kMainHorizontalPadding),
                child: MaterialText(text: kLoremIpsum,),
              ),
              Padding(
                padding: const EdgeInsets.all(kMainHorizontalPadding),
                child: MaterialText(text: kLoremIpsum,),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kMainHorizontalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Reviews', style: kHeadingTextStyle,),
                    Text('See All', style: kHeadingSubTextStyle,),
                  ],
                ),
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
