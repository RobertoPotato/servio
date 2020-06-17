import 'package:flutter/material.dart';
import '../components/review_card.dart';
import '../constants.dart';
import '../components/horizontal_buttons.dart';
import 'map_page.dart';
import 'package:servio/components/my_divider.dart';

class CompanyScreen extends StatelessWidget {
  CompanyScreen(
      {this.companyName,
      this.servicesOffered,
      this.location,
      this.companyImage,
      this.reviews,
      this.companyIsVerified,
      this.successRate,
      this.bio});

  final String companyName;
  final List<String> servicesOffered;
  final String location; //todo make this an actual map location object
  final String companyImage;
  final List<String> reviews;
  final bool companyIsVerified;
  final double successRate;
  final String bio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (Text(companyName)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image(
                image: AssetImage('images/$companyImage'),
                width: double.infinity,
                fit: BoxFit.fitHeight,
              ),
              Padding(
                padding: const EdgeInsets.all(kMainHorizontalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          '$successRate%',
                          style: kHeadingTextStyle.copyWith(
                              fontSize: 24, color: kPrimaryColor),
                        ),
                        Text('Success Rate'),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Icon(
                          Icons.verified_user,
                          color: companyIsVerified ? Colors.blue : Colors.grey,
                          size: 28.0,
                        ),
                        Text(companyIsVerified ? 'Verified' : 'Not Verified'),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        InkWell(
                          child: Icon(
                            Icons.map,
                            size: 28.0,
                            color: kPrimaryColor,
                          ),
                          onTap: () {
                            /*open the map page while passing in the lat and long  to start with*/
                            print("Open Map Page");
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return MapPage(lat: -1.1962, long: 36.9487,);
                            }));
                          },
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          location,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              MyDivider(thickness: 2.0,),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kMainHorizontalPadding),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: kMainHorizontalPadding),
                      child: Text(
                        bio,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    height: 160.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        ReviewCard(
                          reviewerName: 'John Doe',
                          review: kLoremIpsum,
                          reviewerAvatar: 'owl.png',
                          rating: 4.5,
                        ),
                        ReviewCard(
                          reviewerName: 'Jane Doe',
                          review: kLoremIpsumShort,
                          reviewerAvatar: 'owl.png',
                          rating: 2.0,
                        ),
                        ReviewCard(
                          reviewerName: 'Jack Doe',
                          review: kLoremIpsum,
                          reviewerAvatar: 'owl.png',
                          rating: 4.5,
                        ),
                        ReviewCard(
                          reviewerName: 'Joan Doe',
                          review: kLoremIpsumShort,
                          reviewerAvatar: 'owl.png',
                          rating: 4.5,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 70.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        HorizontalButtons(
                          buttonText: 'Company\s first Service',
                        ),
                        HorizontalButtons(
                          buttonText: 'Company\s second Service',
                        ),
                        HorizontalButtons(
                          buttonText: 'Company\s third Service',
                        ),
                        HorizontalButtons(
                          buttonText: 'Company\s fourth Service',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  //todo Implement hire company functionality
                  print('Hire company pressed');
                },
                child: Container(
                  color: kAccentColor,
                  width: double.infinity,
                  height: 50.0,
                  child: Center(
                    child: Text(
                      'HIRE',
                      style: kTestTextStyleWhite,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
