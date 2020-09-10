import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/horizontal_buttons.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(kMainHorizontalPadding),
          child: Text(
            'Top Categories',
            style: kHeadingTextStyle,
            textAlign: TextAlign.start,
          ),
        ),
        Container(
          //color: Colors.white,
          height: 70.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              HorizontalButtons(
                buttonText: 'Example Service',
              ),
              HorizontalButtons(
                buttonText: 'Example Service',
              ),
              HorizontalButtons(
                buttonText: 'Example Service',
              ),
              HorizontalButtons(
                buttonText: 'Example Service',
              ),
            ],
          ),
        ),
      ],
    );
  }
}