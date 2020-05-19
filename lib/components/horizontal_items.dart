import 'package:flutter/material.dart';
import 'package:servio/constants.dart';

class HorizontalCards extends StatelessWidget {
  //todo refactor the names of the variables
  HorizontalCards({@required this.companyImage, @required this.companyName, @required this.location, @required this.openPositions});
  final companyImage;
  final companyName;
  final location;
  final openPositions;

  final double width = 120.0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: kMainHorizontalPadding, top: kMainHorizontalPadding, bottom: kMainHorizontalPadding),
      child: GestureDetector(
        onTap: (){
          //todo Open to the details page with the hero animation for image.
        },
        child: Container(
          width: width,
          child: Card(
            elevation: kElevationValue,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Image(
                      image: AssetImage('images/$companyImage'),
                    ),
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
                          textAlign: TextAlign.center,
                          maxLines: 2),
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