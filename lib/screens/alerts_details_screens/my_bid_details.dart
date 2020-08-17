import 'package:flutter/material.dart';

class MyBidDetails extends StatelessWidget {
  final bid;
  final bidService;
  final serviceStatus;

  MyBidDetails(
      {@required this.bid,
      @required this.bidService,
      @required this.serviceStatus});

  /*String budget(index) {
    if (bid['budgetMin'] > services[index]['budgetMax']) {
      return "${services[index]['budgetMax']} - ${services[index]['budgetMin']}";
    } else {
      return "${services[index]['budgetMin']} - ${services[index]['budgetMax']}";
    }
  }*/

  @override
  Widget build(BuildContext context) {
    print("Bid amount: ${bid["amount"]}");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Bid Details"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  child: Text("The Bid's Details"),
                ),
                Container(
                  child: Text("The Service's Details including Status"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
