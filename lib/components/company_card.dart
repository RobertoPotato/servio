import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/screens/profile_screens/company_profile.dart';
import 'package:servio/components/image_container.dart';

class CompanyCard extends StatelessWidget {
  CompanyCard(
      {@required this.companyName,
      //this.servicesOffered, todo uncomment this and initialize with list
  @required this.location,
  @required this.companyImage,
      //this.reviews, todo uncomment this and initialize with list
  @required this.companyIsVerified,
  @required this.successRate,
  @required this.bio});

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
    'First Service',
    'Second Service',
    'Third Service',
    'Fourth Service',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: kMainHorizontalPadding / 2,
          horizontal: kMainHorizontalPadding),
      child: Card(
        child: Container(
          width: width,
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
                      child: ImageContainer(
                    imageUrl: 'images/$companyImage',
                    height: 48.0,
                    borderRadius: 5.0,
                    isNetworkImage: false,
                    elevation: 0.0,
                  )),
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
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '$location',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(color: kPrimaryColor),
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
/*
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
*/
