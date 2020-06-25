import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/material_text.dart';
import 'package:servio/screens/alerts_details_screens/bid_detail.dart';

class BidCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kMainHorizontalPadding,
          vertical: kMainHorizontalPadding / 2),
      child: Card(
        elevation: kElevationValue,
        child: InkWell(
          onTap: () {
            //todo add data to pass as well as methods to use
            Navigator.pushNamed(context, BidDetails.id);
          },
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                MaterialText(
                                  text: kNumberTotal,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('Rating:  '),
                                MaterialText(
                                  text: kExampleRatingText,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('Bid:  '),
                                MaterialText(
                                  text: kExampleBidPrice,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                                child: Text(
                              kExampleNameMale,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                kLoremIpsum,
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
      ),
    );
  }
}
