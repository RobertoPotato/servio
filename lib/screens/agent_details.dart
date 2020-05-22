import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/review_card.dart';

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
//                  SizedBox(
//                    height: 200.0,
//                  ),
                  //Reviews Section
                  Container(
                    height: 160.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        ReviewCard(reviewerName: 'John Doe', review: kLoremIpsum, reviewerAvatar: '', rating: 4.5,),
                        ReviewCard(reviewerName: 'John Doe', review: kLoremIpsumShort, reviewerAvatar: '', rating: 2.0,),
                        ReviewCard(reviewerName: 'John Doe', review: kLoremIpsum, reviewerAvatar: '', rating: 4.5,),
                        ReviewCard(reviewerName: 'John Doe', review: kLoremIpsumShort, reviewerAvatar: '', rating: 4.5,),
                      ],
                    ),
                  ),
                  //Skills Section
                  Container(
                    height: 100,
                    child: ListView(
                      children: <Widget>[

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
          print('Hire button has been pressed');
        },
        child: Icon(Icons.attach_money),
      ),
    );
  }
}