import 'package:flutter/material.dart';
import 'package:servio/constants.dart';

import 'help_cards.dart';

class HelpItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: kMainHorizontalPadding,
              left: kMainHorizontalPadding,
              right: kMainHorizontalPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("FAQs", style: kHeadingTextStyle,),
              Text("Get more help", style: kHeadingSubTextStyle,),
            ],
          ),
        ),
        Container(
          height: 305.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              HelpCards(
                image: "null",
                title: "Request a service",
                content: "Just do this",
              ),
              HelpCards(
                image: "null",
                title: "Request a service",
                content: "Just do this",
              ),
              HelpCards(
                image: "null",
                title: "Request a service",
                content: "Just do this",
              ),
              HelpCards(
                image: "null",
                title: "Request a service",
                content: "Just do this",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
