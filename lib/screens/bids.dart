import 'package:flutter/material.dart';
import 'package:servio/components/bid_card.dart';
import 'package:servio/models/BidWithServiceAndStatus.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:servio/constants.dart';
import 'alerts_details_screens/my_bid_details.dart';

class Bids extends StatefulWidget {
  static String id = "bids";
  final int userId;

  Bids({@required this.userId});

  @override
  _BidsState createState() => _BidsState();
}

class _BidsState extends State<Bids> {
  Future<BidWithServiceAndStatus> futureBids;
  List bids;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureBids =
        fetchMyBids(); //fetches the bids associated with the current logged-in user
  }

  Future<BidWithServiceAndStatus> fetchMyBids() async {
    var url = "$kBaseUrl/v1/bids/foruser/${widget.userId}";

    final response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    final jsonResponse = json.decode(response.body);

    setState(() {
      bids = json.decode(response.body);
    });

    print(jsonResponse);
    if (response.statusCode == 200) {
      return BidWithServiceAndStatus.fromJson(jsonResponse[0]);
    } else {
      throw Exception('Failed to load Bids');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Bids I've Made"),
        ),
        body: ListView.builder(
            itemCount: bids == null ? 0 : bids.length,
            itemBuilder: (BuildContext context, int index) {
              var currentBidIndex = bids[index];
              var currentServiceIndex = bids[index]["Service"];
              var currentStatusIndex = bids[index]["Service"]["Status"];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => MyBidDetails(
                        bid: currentBidIndex,
                        bidService: currentServiceIndex,
                        serviceStatus: currentStatusIndex,
                      ),
                    ),
                  );
                },
                child: BidCard(
                  currency: currentBidIndex['currency'],
                  amount: currentBidIndex['amount'],
                  userName: "My Bid",
                  description: currentBidIndex['coverLetter'],
                  position: "${index + 1}/${bids.length}",
                ),
              );
            }),
      ),
    );
  }
}
