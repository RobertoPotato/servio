import 'package:flutter/material.dart';
import 'package:servio/constants.dart';

class BidCard extends StatelessWidget {
  final String position;
  final int amount;
  final String userName;
  final String description;
  final String currency;

  BidCard(
      {@required this.amount,
      @required this.userName,
      @required this.description,
      @required this.position,
      @required this.currency});

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
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(position),
                          SizedBox(
                            width: 5.0,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.payment,
                                  color: kMyBidsColor,
                                ),
                                Flexible(
                                  child: Text(
                                    "$currency: $amount",
                                    style: kBottomNavText,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            flex: 3,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.assignment_ind,
                                  color: kMyBidsColor,
                                ),
                                Flexible(
                                  child: Text(
                                    userName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: kHeadingTextStyle.copyWith(
                                        fontSize: 16.0),
                                  ),
                                ),
                              ],
                            ),
                            flex: 5,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              description,
                              maxLines: 4,
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
