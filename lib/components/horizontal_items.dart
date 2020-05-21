import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/screens/agent_details.dart';

class HorizontalCards extends StatelessWidget {
  //todo refactor the names of the variables
  HorizontalCards(
      {@required this.companyImage,
      @required this.companyName,
      @required this.location,
      @required this.openPositions});
  final companyImage;
  final companyName;
  final location;
  final openPositions;

  final double width = 120.0;

  final List<String> reviews = [
    'First Review',
    'Second Review',
    'Third Review',
    'Fourth Review',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: kMainHorizontalPadding,
          top: kMainHorizontalPadding,
          bottom: kMainHorizontalPadding),
      child: Container(
        width: width,
        child: Card(
          elevation: kElevationValue,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AgentDetailsScreen(
                    agentName: companyName,
                    agentRating: openPositions,
                    profileImageTitle: companyImage,
                    userReviews: reviews,
                  ),
                ),
              );
              //Navigator.pushNamed(context, AgentDetailsScreen.id);
            },
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Container(
                    child: CircleAvatar(
                      radius: 42.0,
                      backgroundImage: AssetImage('images/$companyImage'),
                    ),
                    /*child: Image(
                      width: double.infinity,
                      image: AssetImage('images/$companyImage'),
                    ),*/
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        '$companyName',
                        textAlign: TextAlign.center,
                      ),
                      Text('$location',
                          textAlign: TextAlign.center, maxLines: 2),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        '$openPositions position(s)',
                        style: TextStyle(
                            //todo implement text style for positions
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
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
