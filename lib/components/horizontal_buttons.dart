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
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(40.0),
        child: InkWell(
          onTap: () {
            print('Horizontal button pressed');
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
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
