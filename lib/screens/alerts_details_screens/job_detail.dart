import 'dart:async';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/material_text.dart';
import 'package:servio/components/card_title_text.dart';
import 'package:servio/components/job_details_card.dart';
import 'package:servio/components/icon_button_text.dart';
import 'package:servio/screens/make_bid_screen.dart';

class JobDetails extends StatefulWidget {
  static String id = 'job_details';

  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  var lat = -1.1962;
  var long = 36.9487;
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> marker = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    marker.add(
      Marker(
        markerId: MarkerId('our_location'),
        draggable: false,
        onTap: () {
          print('Marker has been tapped');
        },
        position: LatLng(lat, long),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Job Detail(Job Category)'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                //todo implement make favorite and update icon
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CarouselSlider(
                options: CarouselOptions(),
                items: imgList
                    .map(
                      (item) => Container(
                        child: Center(
                          child: Image.network(item,
                              fit: BoxFit.cover, width: 1000),
                        ),
                      ),
                    )
                    .toList(),
              ),
              MaterialText(
                text: kLoremIpsumShort,
                fontStyle: kMainBlackTextStyle,
              ),
              CardWithTitleAndText(
                title: 'Description',
                text: kLoremIpsum,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kMainHorizontalPadding, vertical: kMainHorizontalPadding),
                child: JobDetailsCard(duration: '2 Days', openPositions: 1, budgetRange: '5000 - 7000', jobTerms: 'Part time',),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: kMainHorizontalPadding/2, horizontal: kMainHorizontalPadding),
                child: Card(
                  elevation: kElevationValue/2,
                  child: Container(
                    height: 400.0,
                    child: GoogleMap(
                      mapType: MapType.hybrid,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(lat, long),
                        zoom: 14.5,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      markers: Set.from(marker),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kMainHorizontalPadding, vertical: kMainHorizontalPadding/2),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButtonWithText(
                          text: 'Bid',
                          icon: Icons.sentiment_very_satisfied,
                          materialColor: kMyBidsColor,
                          onTap: (){
                            Navigator.pushNamed(context, MakeBidScreen.id);
                          },
                        ),
                        IconButtonWithText(
                          text: 'Profile',
                          icon: Icons.person,
                          materialColor: kMyJobsColor,
                        ),
                        IconButtonWithText(
                          text: 'Hide',
                          icon: Icons.not_interested,
                          materialColor: kRedAlert,
                        ),
                      ],
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
