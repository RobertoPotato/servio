import 'package:flutter/material.dart';
import 'package:servio/constants.dart';

class IconButtonWithText extends StatelessWidget {
  IconButtonWithText(
      {this.text,
        this.icon,
        this.materialColor,
        this.onTap});
  final String text;
  final icon;
  final Color materialColor;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size(80, 66), // button width and height
      child: Material(
        elevation: kElevationValue / 2,
        borderRadius: BorderRadius.circular(10.0),
        color: materialColor, // button color
        child: InkWell(
          splashColor: Colors.white, // splash color
          onTap: onTap, // button pressed
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon), // icon
              Text("$text"), // text
            ],
          ),
        ),
      ),
    );
  }
}
