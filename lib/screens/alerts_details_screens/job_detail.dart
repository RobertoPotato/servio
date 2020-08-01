import 'dart:async';
import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/material_text.dart';
import 'package:servio/components/card_title_text.dart';
import 'package:servio/components/job_details_card.dart';
import 'package:servio/components/icon_button_text.dart';
import 'package:servio/screens/make_bid_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class JobDetails extends StatefulWidget {
  //static String id = 'job_details';

  final userId;
  final serviceId;
  final categoryTitle;
  final title;
  final description;
  final budget;
  final terms;
  final imageUrl;

  JobDetails(
      {this.userId,
      this.serviceId,
      this.categoryTitle,
      this.title,
      this.description,
      this.budget,
      this.terms,
      this.imageUrl});

  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Category: ${widget.categoryTitle}'),
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
              Image.network(
                  'https://cdn.pixabay.com/photo/2016/04/25/18/07/halcyon-1352522_960_720.jpg',
                  fit: BoxFit
                      .cover), // TODO replace the image link with => widget.imageUrl
              MaterialText(
                text: "Title: ${widget.title}", //title
                fontStyle: kMainBlackTextStyle,
              ),
              CardWithTitleAndText(
                title: 'Description',
                text: '${widget.description}',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kMainHorizontalPadding,
                    vertical: kMainHorizontalPadding / 2),
                child: JobDetailsCard(
                  county: 'Nairobi',
                  town: 'Kahawa',
                  budgetRange: widget.budget,
                  terms: widget.terms,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kMainHorizontalPadding,
                    vertical: kMainHorizontalPadding / 2),
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
                          onTap: () {
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
