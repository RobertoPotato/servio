import 'package:flutter/material.dart';
import 'package:servio/constants.dart';

class HorizontalButtons extends StatelessWidget {
  //todo initialize items
  final String buttonText = 'Example Service';
  //final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: kMainHorizontalPadding,
          top: kMainHorizontalPadding,
          bottom: kMainHorizontalPadding + 6),
      child: Material(
        elevation: kElevationValue,
        color: kMainColor,
        borderRadius: BorderRadius.circular(40.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
          child: FlatButton(
            onPressed: () {
              //todo Do something
            },
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
