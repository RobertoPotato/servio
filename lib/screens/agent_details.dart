import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servio/constants.dart';

class AgentDetailsScreen extends StatelessWidget {
  static String id = 'agentDetails';

  AgentDetailsScreen({this.agentName, this.agentRating, this.profileImageTitle, this.userReviews});

  final String agentName;
  final double agentRating;
  final List <String> userReviews;
  final String profileImageTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/$profileImageTitle'),
              fit: BoxFit.cover,
            )
          ),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(kMainHorizontalPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          agentName,
                          style: kTestTextStyleWhite,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              agentRating.toString(),
                              style: kTestTextStyleWhite,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200.0,
                  ),
                  Container(
                    height: 75.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        ReviewCard(userReview: userReviews[0]),
                        ReviewCard(userReview: userReviews[1]),
                        ReviewCard(userReview: userReviews[2]),
                        ReviewCard(userReview: userReviews[3]),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('FAB has been pressed');
        },
        child: Icon(Icons.attach_money),
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  ReviewCard({this.userReview});
  final userReview;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kMainHorizontalPadding),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            userReview,
            style: kTestTextStyleBlack,
          ),
        ),
        elevation: kElevationValue,
      ),
    );
  }
}
