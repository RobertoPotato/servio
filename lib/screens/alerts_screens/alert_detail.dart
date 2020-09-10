import 'package:flutter/material.dart';
import 'package:servio/date_time.dart';
import 'package:servio/components/material_text.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/card_title_text.dart';
import 'package:servio/components/image_container.dart';
import 'package:servio/screens/job_screens/job_parent_screen.dart';
import 'package:servio/screens/service_screens/my_services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

//These are types attached to alerts to determine which screen the alert opens
//Declared like this for clarity and ease of use..
class Types{
  static const JOBS = "JOBS";
  static const MY_SERVICES = "MY_SERVICES";
}

class AlertDetails extends StatefulWidget {
  final int id;
  final String title;
  final String payload;
  final int createdFor;
  final bool isSeen;
  final String type;
  final date;

  AlertDetails(
      {@required this.isSeen,
      @required this.title,
      @required this.payload,
      @required this.id,
      @required this.createdFor,
      @required this.type,
      @required this.date});

  @override
  _AlertDetailsState createState() => _AlertDetailsState();
}

class _AlertDetailsState extends State<AlertDetails> {
  changeScreen() {
    if (widget.type == Types.MY_SERVICES) {
      Navigator.pushNamed(context, MyServices.id);
    } else if (widget.type == Types.JOBS) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => JobParentScreen(),
        ),
      );
    } else
      return;
  }

  @override
  void initState() {
    // TODO: carry out post to update the alert's isSeen status to true
    super.initState();
    _updateIsSeenStatus(widget.createdFor);
  }

  Future<String> _updateIsSeenStatus(int userId) async{
    //post change to the url specified based on the job id an agentId
    var url = "$kBaseUrl/v1/alerts/${widget.id}/seen";

    final response = await http.put(Uri.encodeFull(url),
        body: json.encode({
          "userId": userId,
        }),
        headers: {
          "accept": "application/json",
          "content-type": "application/json"
        });

    if(response.statusCode == 200) {

      return "Job has been marked as DONE";
    } else {
      return "unable to perform this action";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Notification Details"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kMainHorizontalPadding,
                    vertical: kMainHorizontalPadding / 2),
                child: ImageContainer(
                  elevation: kElevationValue / 2,
                  isNetworkImage: false,
                  borderRadius: 10.0,
                  height: 320.0,
                  imageUrl: "images/undraw_business_decisions_gjwy.png",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: kMainHorizontalPadding,
                    right: kMainHorizontalPadding,
                    top: kMainHorizontalPadding / 2),
                child: MaterialText(
                  text: widget.title,
                  color: kPrimaryColor,
                  fontStyle: kTestTextStyleWhite,
                ),
              ),
              CardWithTitleAndText(
                title: "Sent on ${parseDate(widget.date)}",
                text: widget.payload,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: "Go to page",
          backgroundColor: kAccentColor,
          child: Icon(
            Icons.arrow_forward,
            size: 28.0,
          ),
          onPressed: () {
            print(
                "Button Pressed Type: => ${widget.type}  Types: => ${Types.MY_SERVICES}");
            changeScreen();
          },
        ),
      ),
    );
  }
}