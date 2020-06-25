import 'package:flutter/material.dart';
import 'package:servio/constants.dart';

class HorizontalButtons extends StatelessWidget {
  HorizontalButtons({this.buttonText});

  final String buttonText;
  //final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: kMainHorizontalPadding,
          right: kMainHorizontalPadding/2,
          top: kMainHorizontalPadding,
          bottom: kMainHorizontalPadding + 6),
      child: Material(
        elevation: kElevationValue/2,
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
