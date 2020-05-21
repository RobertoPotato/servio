import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/horizontal_items.dart';
import 'package:servio/components/horizontal_buttons.dart';
import 'package:servio/components/job_items_vertical.dart';

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
            },
          )
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
                        HorizontalButtons(),
                        HorizontalButtons(),
                        HorizontalButtons(),
                        HorizontalButtons(),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    //color: Colors.white,
                    height: 180.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        HorizontalCards(
                          companyImage: 'hands.png',
                          companyName: 'Company Name',
                          location: 'Location',
                          openPositions: 10.0,
                        ),
                        HorizontalCards(
                          companyImage: 'agent_image.jpg',
                          companyName: 'Company Name',
                          location: 'Location',
                          openPositions: 20.0,
                        ),
                        HorizontalCards(
                          companyImage: 'hands.png',
                          companyName: 'Company Name',
                          location: 'Location',
                          openPositions: 10.0,
                        ),
                        HorizontalCards(
                          companyImage: 'agent_image.jpg',
                          companyName: 'Company Name',
                          location: 'Location',
                          openPositions: 3.0,
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
              ), //has vertically scrolling widgets
            ],
          ),
        ),
      ),
    );
  }
}
