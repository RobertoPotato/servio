import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/screens/company.dart';

class CompanyCard extends StatelessWidget {
  CompanyCard(
      {this.companyName,
      //this.servicesOffered, todo uncomment this and initialize with list
      this.location,
      this.companyImage,
      //this.reviews, todo uncomment this and initialize with list
      this.companyIsVerified,
      this.successRate,
      this.bio});

  final String companyName;
  //final List<String> servicesOffered; todo uncomment this
  final String location; //todo make this an actual map location object
  final String companyImage;
  //final List<String> reviews; todo uncomment this
  final bool companyIsVerified;
  final double successRate;
  final String bio;

  final double width = 120.0;

  final List<String> reviews = [
    'First Review',
    'Second Review',
    'Third Review',
    'Fourth Review',
  ];

  final List<String> servicesOffered = [
    'First Review',
    'Second Review',
    'Third Review',
    'Fourth Review',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: kMainHorizontalPadding,
          top: kMainHorizontalPadding,
          bottom: kMainHorizontalPadding),
      child: Container(
        width: width,
        child: Card(
          elevation: kElevationValue,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CompanyScreen(
                    companyName: companyName,
                    servicesOffered: servicesOffered,
                    location: location,
                    companyImage: companyImage,
                    reviews: reviews,
                    companyIsVerified: companyIsVerified,
                    successRate: successRate,
                    bio: bio,
                  ),
                ),
              );
            },
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Container(
                    child: CircleAvatar(
                      radius: 48.0,
                      backgroundImage: AssetImage('images/$companyImage'),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          '$companyName',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text('$location',
                          textAlign: TextAlign.center, maxLines: 2, style: TextStyle(color: kPrimaryColor),),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        '$successRate% success',
                        style: TextStyle(
                            //todo implement text style for positions
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

