import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
class DetailsContainer extends StatelessWidget {

  final String title;
  final String content;

  const DetailsContainer({@required this.title, @required this.content});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: kHeadingTextStyle,
          ),
          Text(content,
              style: kHeadingSubTextStyle),
        ],
      ),
    );
  }
}
