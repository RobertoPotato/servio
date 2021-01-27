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
                location: "Kenya",
                companyName: "Coloors.ke",
                companyImage: "icon.png",
                companyIsVerified: true,
                bio: "Some Lorem ipsum",
                successRate: 85,
              ),
              CompanyCard(
                location: "Uganda",
                companyName: "Food Co.",
                companyImage: "Notify.png",
                companyIsVerified: false,
                bio: "Some Lorem ipsum",
                successRate: 85,
              ),
              CompanyCard(
                location: "Tanzania",
                companyName: "Tech Company",
                companyImage: "confirmed.png",
                companyIsVerified: true,
                bio: "Some Lorem ipsum",
                successRate: 85,
              ),
              CompanyCard(
                location: "Rwanda",
                companyName: "The Good LLC",
                companyImage: "Alien-Butt.gif",
                companyIsVerified: false,
                bio: "Some Lorem ipsum",
                successRate: 85,
              ),
              CompanyCard(
                location: "Ethiopia",
                companyName: "One company",
                companyImage: "business_woman.jpg",
                companyIsVerified: true,
                bio: "Some Lorem ipsum",
                successRate: 85,
              ),
            ],
          ),
        ),
      ],
    );
  }
}