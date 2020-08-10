import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/material_text.dart';
import 'package:servio/screens/alerts_details_screens/bid_detail.dart';

class BidCard extends StatelessWidget {
  final String position;
  final int amount;
  final String userName;
  final String description;

  BidCard({@required this.amount, @required this.userName, @required this.description, @required this.position});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kMainHorizontalPadding,
          vertical: kMainHorizontalPadding / 2),
      child: Card(
        elevation: kElevationValue / 2,
        child: Container(
          height: 150.0,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kMainHorizontalPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: MaterialText(
                              text: position,
                              color: kMyJobsColor,
                            ),
                            flex: 1,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: MaterialText(
                              text: "Amount: $amount",
                              color: Colors.blue,
                            ),
                            flex: 2,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              userName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: kHeadingTextStyle,
                              textAlign: TextAlign.end,
                            ),
                            flex: 3,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              description,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ],
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
