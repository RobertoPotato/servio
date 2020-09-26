import 'package:flutter/material.dart';
import 'package:servio/constants.dart';

class CardWithTitleAndText extends StatelessWidget {
  CardWithTitleAndText({this.title, this.text});
  final String title;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kMainHorizontalPadding),
      child: Card(
        elevation: kElevationValue / 2,
        child: Padding(
          padding: const EdgeInsets.all(kMainHorizontalPadding),
          child: Column(
            children: <Widget>[
              Text(
                '$title',
                style: kHeadingTextStyle,
              ),
              Text(
                '$text',
                style: kMainBlackTextStyle.copyWith(color: Colors.grey[700], fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}