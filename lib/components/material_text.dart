import 'package:flutter/material.dart';
import 'package:servio/constants.dart';

class MaterialText extends StatelessWidget {
  MaterialText({this.text, this.color, this.fontStyle});
  final text;
  final color;
  final fontStyle;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kMainHorizontalPadding,
            vertical: kMainHorizontalPadding / 2),
        child: Text(
          text.toString(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: fontStyle,
        ),
      ),
      elevation: kElevationValue / 2,
      borderRadius: BorderRadius.circular(4.0),
      color: color,
    );
  }
}
