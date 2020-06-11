import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/material_text.dart';

class BidCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: kElevationValue,
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
                        MaterialText(text: kNumberTotal, color: Colors.red,),
                        MaterialText(text: kExampleRatingText, color: Colors.green,),
                        MaterialText(text: kExampleBidPrice, color: Colors.blue,),
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
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      print('Profile button pressed');
                    },
                    child: Text('Profile'),
                    color: kColorButtons.shade400,
                  ),
                  RaisedButton(
                    onPressed: () {
                      print('Hire button pressed');
                    },
                    child: Text('Hire'),
                    color: kColorButtons.shade500,
                  ),
                  RaisedButton(
                    onPressed: () {
                      print('Hide button pressed');
                    },
                    child: Text('Hide'),
                    color: kColorButtons.shade600,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
