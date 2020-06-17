import 'package:flutter/material.dart';
import 'package:servio/constants.dart';

class MyDivider extends StatelessWidget {
  MyDivider({this.thickness});
  final thickness;
  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: kMainHorizontalPadding,
      endIndent: kMainHorizontalPadding,
      thickness: thickness,
      color: kPrimaryColor,
    );
  }
}
