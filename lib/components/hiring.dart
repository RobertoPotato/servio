import 'package:flutter/material.dart';
import 'package:servio/components/company_card.dart';
import 'package:servio/constants.dart';

class NowHiring extends StatelessWidget {
  const NowHiring({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(kMainHorizontalPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Now Hiring',
                style: kHeadingTextStyle,
              ),
              Text(
                'See All',
                style: kHeadingSubTextStyle,
              ),
            ],
          ),
        ),
        Container(
          //color: Colors.white,
          height: 200.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              CompanyCard(
                location: "Lavington",
                companyName: "Tenscapes.io",
                companyImage: "icon.png",
              ),
              CompanyCard(
                location: "Garden City",
                companyName: "Janii",
                companyImage: "Notify.png",
              ),
              CompanyCard(
                location: "Westlands",
                companyName: "Tokeaa",
                companyImage: "confirmed.png",
              ),
              CompanyCard(
                location: "San Fransisco",
                companyName: "Trinity Automobiles",
                companyImage: "Alien-Butt.gif",
              ),
              CompanyCard(
                location: "UAE",
                companyName: "Seer Hotels",
                companyImage: "business_woman.jpg",
              ),
            ],
          ),
        ),
      ],
    );
  }
}