import 'package:flutter/material.dart';
import 'package:servio/constants.dart';

class VerticalJobCards extends StatelessWidget {
  //todo refactor the names of the variables
  VerticalJobCards(
      {@required this.companyImage,
      @required this.companyName,
      @required this.location,
      @required this.openPositions});
  final companyImage;
  final companyName;
  final location;
  final openPositions;

  final double height = 90.0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: kMainHorizontalPadding, right: kMainHorizontalPadding, top: 8.0),
      child: Container(
        width: double.infinity,
        height: height,
        child: Card(
          elevation: kElevationValue,
          child: InkWell(
            onTap: (){
              //todo Navigate to job details screen
              print('Job vertical item clicked');
            },
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Image(
                      image: AssetImage('images/$companyImage'),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(kMainHorizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              '$companyName',
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '$location',
                              textAlign: TextAlign.center,
                              maxLines: 1,
                            ),
                            Text(
                              '$openPositions position(s)',
                              style: TextStyle(
                                  //todo implement text style for positions
                                  ),
                              textAlign: TextAlign.center,
                            ),
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
