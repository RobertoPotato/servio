import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servio/constants.dart';

class ReviewCard extends StatelessWidget {
  //todo refactor the names of the variables
  ReviewCard(
      {@required this.reviewerName,
        @required this.reviewerAvatar,
        @required this.review,
        @required this.rating});
  final String reviewerName;
  final String reviewerAvatar;
  final String review;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: kMainHorizontalPadding, bottom: kMainHorizontalPadding, top: kMainHorizontalPadding),
      child: Container(
        width: 320.0,
        child: Card(
          color: Color(0x66000000),
          child: InkWell(
            onTap: (){
              //todo Navigate to job details screen
              print('Review Item Clicked');
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: kMainHorizontalPadding, horizontal: kMainHorizontalPadding),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Image(
                        image: AssetImage('images/$reviewerAvatar'),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '$reviewerName',
                              style: kHeadingTextStyle.copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  '$rating',
                                  style: kHeadingTextStyle.copyWith(color: Colors.lightBlueAccent),
                                ),
                                Icon(Icons.star, size: 24, color: rating > 2.5 ? Colors.green : Colors.deepOrange,),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                '$review',
                                textAlign: TextAlign.start,
                                maxLines: 4,
                                style: kTestTextStyleBlack.copyWith(letterSpacing: 1.2, fontSize: 15, color: kAccentColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
