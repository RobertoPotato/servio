import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/company_card.dart';
import 'package:servio/components/horizontal_buttons.dart';
import 'package:servio/components/job_items_vertical.dart';
import 'package:servio/screens/request_service.dart';
// todo uncomment when needed: import 'package:servio/components/search_delegate.dart';

class HomeScreen extends StatelessWidget {
  static String id = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: kElevationValue,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black54,
              size: 30,
            ),
            onPressed: () {
              //todo implement search functionality
              //showSearch(context: context, delegate: ServiceSearchDelegate());
            },
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black54,
              size: 36,
            ),
            onPressed: () {
              Navigator.pushNamed(context, RequestServicePage.id);
            },
          ),
        ],
        //elevation: kElevationValue,
        title: Text(
          'Home',
          style: kAppBarTitle,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(kMainHorizontalPadding),
                    child: Text(
                      'Top Categories',
                      style: kHeadingTextStyle,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    //color: Colors.white,
                    height: 70.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        HorizontalButtons(
                          buttonText: 'Example Service',
                        ),
                        HorizontalButtons(
                          buttonText: 'Example Service',
                        ),
                        HorizontalButtons(
                          buttonText: 'Example Service',
                        ),
                        HorizontalButtons(
                          buttonText: 'Example Service',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
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
                          companyName: 'This Company',
                          //servicesOffered,
                          location: 'Mombasa',
                          companyImage: 'hands.png',
                          //reviews,
                          companyIsVerified: true,
                          successRate: 90.0,
                          bio: kLoremIpsum,
                        ),
                        CompanyCard(
                          companyName: 'Another Company',
                          //servicesOffered,
                          location: 'Kisumu',
                          companyImage: 'agent_image.jpg',
                          //reviews,
                          companyIsVerified: false,
                          successRate: 10.0,
                          bio: kLoremIpsum,
                        ),
                        CompanyCard(
                          companyName: 'Awesome Company in the country',
                          //servicesOffered,
                          location: 'Nairobi',
                          companyImage: 'hands.png',
                          //reviews,
                          companyIsVerified: true,
                          successRate: 30.0,
                          bio: kLoremIpsum,
                        ),
                        CompanyCard(
                          companyName: 'Another Company',
                          //servicesOffered,
                          location: 'Kabete',
                          companyImage: 'agent_image.jpg',
                          //reviews,
                          companyIsVerified: true,
                          successRate: 70.0,
                          bio: kLoremIpsum,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(kMainHorizontalPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Categories for you',
                          style: kHeadingTextStyle,
                        ),
                        Text(
                          'See All',
                          style: kHeadingSubTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      VerticalJobCards(
                        companyImage: 'hands.png',
                        companyName: 'Company Name',
                        location: 'Location',
                        openPositions: 10,
                      ),
                      VerticalJobCards(
                        companyImage: 'hands.png',
                        companyName: 'Company Name',
                        location: 'Location',
                        openPositions: 10,
                      ),
                      VerticalJobCards(
                        companyImage: 'hands.png',
                        companyName: 'Company Name',
                        location: 'Location',
                        openPositions: 10,
                      ),
                      VerticalJobCards(
                        companyImage: 'hands.png',
                        companyName: 'Company Name',
                        location: 'Location',
                        openPositions: 10,
                      ),
                      VerticalJobCards(
                        companyImage: 'hands.png',
                        companyName: 'Company Name',
                        location: 'Location',
                        openPositions: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
