import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:servio/components/bid_card.dart';
import 'package:servio/jwt_helpers.dart';
import 'package:servio/models/BidWithServiceAndStatus.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:servio/constants.dart';
import 'my_bid_details.dart';

class Bids extends StatefulWidget {
  final String token;

  Bids({@required this.token});

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
    //User fetches bids made by them
    var url = "$kBaseUrl/v1/bids/mine";

    try {
      final response = await http.get(Uri.encodeFull(url),
          headers: {"Accept": "application/json", "x-auth-token": widget.token}).timeout(Duration(seconds: kNetworkRequestTimeOutDuration));

      final jsonResponse = json.decode(response.body);

      setState(() {
        bids = json.decode(response.body);
      });

      if (response.statusCode == 200) {
        return BidWithServiceAndStatus.fromJson(jsonResponse[0]);
      } else {
        throw Exception('Failed to load Bids');
      }
    } on TimeoutException catch(e){
      print(e.message);
      displayResponseCard(context, "Error", kRequestTimedOut, kErrorImage);

    } on SocketException catch(e){
      print(e.message);
      displayResponseCard(context, "Error", kNoConnection, kErrorImage);
    }
    //FIXME
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Bids I've Made"),
        ),
        body: bids == null
            ? Center(child: CircularProgressIndicator())
            : bids.length == 0
                ? Center(child: Text(kNoBidsMadePrompt))
                : ListView.builder(
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
                          amount: currentBidIndex['amount'].toDouble(),
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
