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
      padding: const EdgeInsets.only(
          left: kMainHorizontalPadding,
          right: kMainHorizontalPadding/2,
          bottom: kMainHorizontalPadding,
          top: kMainHorizontalPadding),
      child: Container(
        width: 320.0,
        child: Card(
          elevation: kElevationValue/2,
          child: InkWell(
            onTap: () {
              //todo Navigate to job details screen
              print('Review Item Clicked');
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: kMainHorizontalPadding,
                  horizontal: kMainHorizontalPadding),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: CircleAvatar(
                        radius: 40.0,
                        backgroundImage: AssetImage('images/$reviewerAvatar'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
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
                              style: kHeadingTextStyle.copyWith(
                                  color: Colors.black54),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  '$rating',
                                  style: kHeadingTextStyle,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 24,
                                  color: rating > 2.5
                                      ? Colors.green
                                      : Colors.deepOrange,
                                ),
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
                                style: kTestTextStyleBlack.copyWith(
                                    fontSize: 15, color: Colors.black),
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
