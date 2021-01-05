import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/divider_component.dart';
import 'package:servio/components/image_container.dart';
import 'package:servio/components/grid_details_card.dart';
import 'package:servio/jwt_helpers.dart';
import 'package:servio/models/ErrorResponse.dart';
import 'package:servio/screens/image_screen.dart';
import 'package:servio/components/details_container.dart';
import 'package:servio/components/icon_button_text.dart';
import 'package:http/http.dart' as http;

class MyBidDetails extends StatefulWidget {
  final bid;
  final bidService;
  final serviceStatus;
  final token;

  MyBidDetails(
      {@required this.bid,
      @required this.bidService,
      @required this.serviceStatus,
      @required this.token});

  @override
  _MyBidDetailsState createState() => _MyBidDetailsState();
}

class _MyBidDetailsState extends State<MyBidDetails> {
  Future<String> withdrawBid(
      {@required String token, @required bidId, @required ctxt}) async {
    final url = "$kBaseUrl/v1/bids/$bidId";

    final response = await http.delete(Uri.encodeFull(url), headers: {
      "accept": "application/json",
      "content-type": "application/json",
      "x-auth-token": "$token"
    });

    if (response.statusCode == 200) {
      displayResponseCard(
          ctxt, "Success", "Your bid was removed", kSuccessImage);
      return "Bid removed";
    } else {
      var error = errorFromJson(response.body);
      displayResponseCard(ctxt, kUniversalErrorTitle, error.error, kErrorImage);
      return kSomethingWrongException;
    }
  }

  String budget(min, max) {
    if (min > max) {
      return "$max - $min";
    } else {
      return "$min - $max";
    }
  }

  String isBidInRange(min, max, amt) {
    if (amt < min) {
      return "Your bid was below the asking price";
    } else if (amt > max) {
      return "Your bid was above the asking price";
    } else
      return "Your bid was within the customer's budget range";
  }

  @override
  Widget build(BuildContext context) {
    _showSnack(BuildContext context, String text) {
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
                  (widget.bidService["title"]),
                );
              },
              child: Text(widget.bidService["title"]),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    //TODO Change this image URL to something relevant
                    MaterialPageRoute(
                      builder: (BuildContext context) => ImageScreen(
                          imageUrl: kNetworkImage, isNetworkImage: true),
                    ),
                  );
                },
                child: ImageContainer(
                    borderRadius: 10.0,
                    bottomLeftRad: 30.0,
                    bottomRightRad: 30.0,
                    elevation: 2.0,
                    imageUrl: kNetworkImage,
                    isNetworkImage: true,
                    height: 360.0),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: kMainHorizontalPadding / 2,
                    horizontal: kMainHorizontalPadding),
                child: Column(
                  children: [
                    DetailsContainer(
                        title: "Description",
                        content: "${widget.bidService["description"]}"),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: GridDetailsCard(
                          row1col1: "Budget",
                          row1col2:
                              "${budget(widget.bidService["budgetMin"], widget.bidService["budgetMax"])}",
                          row2col1: "Bid amount",
                          row2col2:
                              "${widget.bid["currency"]} ${widget.bid["amount"]}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: DividerComponent(
                        height: 1.5,
                        width: double.infinity,
                        color: kPrimaryColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: DetailsContainer(
                        title: "Cover Letter",
                        content: "${widget.bid["coverLetter"]}",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: DividerComponent(
                        height: 1.5,
                        width: double.infinity,
                        color: kPrimaryColor,
                      ),
                    ),
                    ListTile(
                      trailing:
                          Icon(Icons.card_travel, color: Colors.blueAccent),
                      title: widget.bid["canTravel"]
                          ? Text("You mentioned you can travel")
                          : Text("You mentioned you can't travel"),
                      subtitle: Text(kTravelPromptExplanation),
                    ),
                    ListTile(
                      trailing:
                          Icon(Icons.access_time, color: Colors.blueAccent),
                      title: Text(
                          "Your availability: ${widget.bid["availability"]}"),
                      subtitle: Text("This shows your preferred availability"),
                    ),
                    ListTile(
                      trailing:
                          Icon(Icons.compare_arrows, color: Colors.blueAccent),
                      title: Text(
                        isBidInRange(
                            widget.bidService["budgetMin"],
                            widget.bidService["budgetMax"],
                            widget.bid["amount"]),
                      ),
                      subtitle: Text("Something you may like to know..."),
                    ),
                    ListTile(
                      title: Text("Status: ${widget.serviceStatus["title"]}"),
                      subtitle: Text(kStatusExplanation),
                      trailing: Builder(
                        builder: (context) => InkWell(
                          child: Icon(Icons.help_outline,
                              color: Colors.blueAccent),
                          onTap: () {
                            _showSnack(context, kStatusExplanation);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(kMainHorizontalPadding),
                      child: IconButtonWithText(
                        text: "Unbid",
                        icon: Icons.remove_circle,
                        materialColor: Colors.grey[400],
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Heads up!"),
                              content: Text(
                                  "Sure you want to withdraw your bid? This action can't be undone"),
                              actions: [
                                FlatButton(
                                    onPressed: () {
                                      withdrawBid(
                                          token: widget.token,
                                          bidId: widget.bid["id"],
                                          ctxt: context);
                                    },
                                    child: Text("Unbid")),
                                FlatButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel")),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
