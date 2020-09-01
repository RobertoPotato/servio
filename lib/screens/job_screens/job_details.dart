import 'package:flutter/material.dart';
import 'package:servio/components/icon_button_text.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/basic_profile.dart';
import 'package:servio/components/card_title_text.dart';
import 'package:servio/components/material_text.dart';

class JobDetails extends StatefulWidget {
  final client;
  final agent;
  final bid;
  final service;
  final status;
  final jobStart;
  final bool userIsClient;

  const JobDetails(
      {@required this.client,
      @required this.agent,
      @required this.bid,
      @required this.service,
      @required this.status,
      @required this.jobStart,
      //checks if the info coming is from the role of the current user being the client
      @required this.userIsClient});
  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  /*TODO
     if user is client, fetch part of the agent's profile and store it to be used
     in the popup banner and if user is agent then fetch the client's profile instead.
     all we do is use different URLs for each case
  * */
  @override
  Widget build(BuildContext context) {
    _showSnack(BuildContext context, text) {
      final snackBar = SnackBar(
        content: Text(text),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Builder(
            builder: (context) => InkWell(
              onTap: () {
                _showSnack(
                  context,
                  widget.userIsClient
                      ? 'Agent\'s name: ${widget.agent['firstName']} ${widget.agent['lastName']}'
                      : 'Client\'s name: ${widget.client['firstName']} ${widget.client['lastName']}',
                );
              },
              child: Text(
                  widget.userIsClient
                      ? 'Agent\'s name: ${widget.agent['firstName']} ${widget.agent['lastName']}'
                      : 'Client\'s name: ${widget.client['firstName']} ${widget.client['lastName']}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text('This here is the details page for the jobs'),
              Text('Agent/client profile'),
              Text('Details about the service'),
              Text('Status of the service'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButtonWithText(
                    onTap: () {},
                    text: 'Completed',
                    icon: Icons.done,
                    materialColor: kAccentColor,
                  ),
                  IconButtonWithText(
                    onTap: () {
                      showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Column(
                              children: [
                                Container(
                                  child: BasicProfilePopup(
                                    isVerified: true,
                                    phoneNumber: "0775603444",
                                    avatar: 'Just a pic',
                                    name: "Roberto Potato",
                                  ),
                                ),
                                widget.userIsClient
                                    ? CardWithTitleAndText(
                                        title:
                                            'Winning Bid: ${widget.bid['amount']}',
                                        text:
                                            "${widget.bid['coverLetter']} and is available ${widget.bid['availability']}",
                                      )
                                    : MaterialText(
                                        text:
                                            "Started on: ${widget.jobStart}",
                                        color: kPrimaryColor,
                                        fontStyle: kHeadingSubTextStyle
                                            .copyWith(color: Colors.white),
                                      ) /*Text(
                                        "Show start date: ${widget.jobStart}"),*/
                              ],
                            );
                          });
                    },
                    text: 'Profile',
                    icon: Icons.person,
                    materialColor: kMyJobsColor,
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
