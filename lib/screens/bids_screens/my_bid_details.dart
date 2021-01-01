import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/divider_component.dart';
import 'package:servio/components/image_container.dart';
import 'package:servio/components/grid_details_card.dart';

class MyBidDetails extends StatelessWidget {
  final bid;
  final bidService;
  final serviceStatus;

  MyBidDetails(
      {@required this.bid,
      @required this.bidService,
      @required this.serviceStatus});

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
                  (bidService["title"]),
                );
              },
              child: Text(bidService["title"]),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kMainHorizontalPadding,
                vertical: kMainHorizontalPadding),
            child: Column(
              children: [
                ImageContainer(
                    borderRadius: 10.0,
                    elevation: 2.0,
                    imageUrl: kNetworkImage,
                    isNetworkImage: true,
                    height: 300.0),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: kHeadingTextStyle,
                      ),
                      Text("${bidService["description"]}",
                          style: kHeadingSubTextStyle),
                    ],
                  ),
                ),
                GridDetailsCard(
                    row1col1: "Budget",
                    row1col2:
                        "${budget(bidService["budgetMin"], bidService["budgetMax"])}",
                    row2col1: "Bid amount",
                    row2col2: "${bid["currency"]} ${bid["amount"]}"),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DividerComponent(
                    height: 1.5,
                    width: double.infinity,
                    color: kPrimaryColor,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cover Letter",
                        style: kHeadingTextStyle,
                      ),
                      Text(
                        "${bid["coverLetter"]}",
                        style: kHeadingSubTextStyle,
                      ),
                    ],
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
                  trailing: Icon(Icons.card_travel, color: Colors.blueAccent),
                  title: bid["canTravel"]
                      ? Text("You mentioned you can travel")
                      : Text("You mentioned you can't travel"),
                  subtitle: Text(kTravelPromptExplanation),
                ),
                ListTile(
                  trailing: Icon(Icons.access_time, color: Colors.blueAccent),
                  title: Text("Your availability: ${bid["availability"]}"),
                  subtitle: Text("This shows your preferred availability"),
                ),
                ListTile(
                  trailing:
                      Icon(Icons.compare_arrows, color: Colors.blueAccent),
                  title: Text(
                    isBidInRange(bidService["budgetMin"],
                        bidService["budgetMax"], bid["amount"]),
                  ),
                  subtitle: Text("Something you may like to know..."),
                ),
                ListTile(
                  title: Text("Status: ${serviceStatus["title"]}"),
                  subtitle: Text(kStatusExplanation),
                  trailing: Builder(
                    builder: (context) => InkWell(
                      child: Icon(Icons.help_outline, color: Colors.blueAccent),
                      onTap: () {
                        _showSnack(context, kStatusExplanation);
                      },
                    ),
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
