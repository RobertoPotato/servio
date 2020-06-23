import 'package:flutter/material.dart';

class MyVerticalDivider extends StatelessWidget {
  MyVerticalDivider({this.height, this.width, this.color});
  final double height;
  final double width;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: color,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
    );
  }
}