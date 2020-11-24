import 'package:flutter/material.dart';
import 'package:servio/components/bid_card.dart';
import 'package:http/http.dart' as http;
import 'package:servio/models/BidWithUserName.dart';
import 'package:servio/constants.dart';
import 'dart:convert';
import 'package:servio/screens/bids_screens/bid_detail.dart';

class MyServicesBids extends StatefulWidget {
  static String id = "bids";
  final int serviceId;
  final String token;

  MyServicesBids({@required this.serviceId, @required this.token});

  @override
  _MyServicesBidsState createState() => _MyServicesBidsState();
}

class _MyServicesBidsState extends State<MyServicesBids> {
  Future<BidWithUserName> futureBidWithUserName;
  List bidsWithUserNames;

  @override
  void initState() {
    super.initState();
    futureBidWithUserName = fetchBidsWithUserNames();
  }

  Future<BidWithUserName> fetchBidsWithUserNames() async {
    var url = "$kBaseUrl/v1/bids/formyservice/${widget.serviceId}";

    final response = await http.get(Uri.encodeFull(url),
        headers: {"Accept": "application/json", "x-auth-token": widget.token});

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
        body: bidsWithUserNames == null
            ? Text('No bids for this service yet')
            : ListView.builder(
                itemCount:
                    bidsWithUserNames == null ? 0 : bidsWithUserNames.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      //Navigate to bid details page
                      var bidsDataArr = bidsWithUserNames[index];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => BidDetails(
                            token: widget.token,
                            serviceId: widget.serviceId,
                            bidId: bidsDataArr['id'],
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
                      amount: bidsWithUserNames[index]['amount'].toDouble(),
                      userName:
                          "${bidsWithUserNames[index]['User']['firstName']} ${bidsWithUserNames[index]['User']['lastName']} ",
                      description: bidsWithUserNames[index]['coverLetter'],
                      position: "${index + 1}/${bidsWithUserNames.length}",
                    ),
                  );
                }),
      ),
    );
  }
}
