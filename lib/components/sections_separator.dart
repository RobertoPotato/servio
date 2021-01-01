import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/divider_component.dart';

class SectionsSeparator extends StatelessWidget {
  SectionsSeparator({@required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: DividerComponent(
            height: 1.5,
            width: double.infinity,
            color: kPrimaryColor,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: DividerComponent(
            height: 1.5,
            width: double.infinity,
            color: kPrimaryColor,
          ),
        ),
      ],
    );
  }
}
