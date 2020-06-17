import 'package:flutter/material.dart';
import 'package:servio/constants.dart';

class MaterialText extends StatelessWidget {
  MaterialText({this.text, this.color});
  final text;
  final color;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
        child: Text(
          text.toString(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      elevation: kElevationValue / 2,
      borderRadius: BorderRadius.circular(5.0),
      color: color,
    );
  }
}