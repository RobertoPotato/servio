import 'package:flutter/material.dart';
import 'package:servio/components/bid_card.dart';
import 'package:http/http.dart' as http;
import 'package:servio/models/BidWithUserName.dart';
import 'package:servio/constants.dart';
import 'dart:convert';
import 'package:servio/screens/alerts_details_screens/bid_detail.dart';

class MyServicesBids extends StatefulWidget {
  static String id = "bids";
  final int serviceId;

  MyServicesBids({this.serviceId});

  @override
  _MyServicesBidsState createState() => _MyServicesBidsState();
}

class _MyServicesBidsState extends State<MyServicesBids> {
  Future<BidWithUserName> futureBidWithUserName;
  List bidsWithUserNames;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureBidWithUserName = fetchBidsWithUserNames();
  }

  Future<BidWithUserName> fetchBidsWithUserNames() async {
    var url = "$kBaseUrl/v1/bids/formyservice/${widget.serviceId}";

    final response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    final jsonResponse = json.decode(response.body);

    setState(() {
      bidsWithUserNames = json.decode(response.body);
    });

    if (response.statusCode == 200) {
      return BidWithUserName.fromJson(jsonResponse[0]);
    } else {
      throw Exception('Failed to load Bids With User Names');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Bids"),
        ),
        body: ListView.builder(
            itemCount: bidsWithUserNames == null ? 0 : bidsWithUserNames.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  //TODO Navigate to bid details page
                  var bidsDataArr = bidsWithUserNames[index];
                  print("Bid has been clicked. id: ${bidsDataArr['userId']}");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => BidDetails(
                        userId: bidsDataArr['userId'],
                        amount: bidsDataArr['amount'].toDouble(),
                        coverLetter: bidsDataArr['coverLetter'],
                        userName:
                            "${bidsWithUserNames[index]['User']['firstName']} ${bidsWithUserNames[index]['User']['lastName']} ",
                        updatedAt: bidsDataArr['updatedAt'],
                        canTravel: bidsDataArr['canTravel'],
                        currency: bidsDataArr['currency'],
                        availability: bidsDataArr['availability'],
                      ),
                    ),
                  );
                },
                child: BidCard(
                  currency: bidsWithUserNames[index]['currency'],
                  amount: bidsWithUserNames[index]['amount'],
                  userName:
                      "${bidsWithUserNames[index]['User']['firstName']} ${bidsWithUserNames[index]['User']['lastName']} ",
                  description: bidsWithUserNames[index]['coverLetter'],
                  position: "${index + 1}/${bidsWithUserNames.length}",
                ),
              );
            }),

        /*SingleChildScrollView(
          child: Column(
            children: <Widget>[
              BidCard(),
              BidCard(),
              BidCard(),
              BidCard(),
              BidCard(),
              BidCard(),
              BidCard(),
              BidCard(),
            ],
          ),
        ),*/
      ),
    );
  }
}
