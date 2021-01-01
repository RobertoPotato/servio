import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/divider_component.dart';

class StatsWidget extends StatelessWidget {
  final double rating;
  final double successrate;
  final bool isVerified;

  StatsWidget(
      {@required this.rating,
        @required this.successrate,
        @required this.isVerified});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: kElevationValue / 2,
      child: Padding(
        padding: const EdgeInsets.all(kMainHorizontalPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[Text(rating.toString()), Text('Rating')],
            ),
            DividerComponent(
              height: 28.0,
              width: 1.0,
              color: kPrimaryColor,
            ),
            Column(
              children: <Widget>[Text('$successrate %'), Text('Success rate')],
            ),
            DividerComponent(
              height: 28.0,
              width: 1.0,
              color: kPrimaryColor,
            ),
            Column(
              children: <Widget>[
                Icon(
                  Icons.verified_user,
                  color: isVerified ? Colors.blue : Colors.grey,
                  size: 28.0,
                ),
                Text(isVerified ? 'Verified' : 'Not Verified'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}