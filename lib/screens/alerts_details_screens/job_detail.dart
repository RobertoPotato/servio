import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/material_text.dart';
import 'package:servio/components/card_title_text.dart';
import 'package:servio/components/job_details_card.dart';
import 'package:servio/components/icon_button_text.dart';
import 'package:servio/screens/make_bid_screen.dart';


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
  final county;
  final town;
  final lat;
  final long;

  JobDetails(
      {this.userId,
      this.serviceId,
      this.categoryTitle,
      this.title,
      this.description,
      this.budget,
      this.terms,
      this.imageUrl,
        this.county,
        this.town,
        this.lat,
        this.long
      });

  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {

  @override
  Widget build(BuildContext context) {
    //TODO print => print(widget.)
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
                  widget.imageUrl,
                  fit: BoxFit
                      .cover),
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
                  county: widget.county,
                  town: widget.town,
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
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MakeBidScreen(
                              serviceId: 1,
                              serviceCategory: "${widget.categoryTitle}",
                              serviceTitle: "${widget.title}",
                              userId: kUserId, //TODO Implement function to get my user id (Currently logged-in user)
                            )));
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
