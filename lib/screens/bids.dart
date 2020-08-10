import 'package:flutter/material.dart';

class Bids extends StatelessWidget {
  static String id = "bids";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Bids"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //BidCard(),
              Text("Bid 1"),
              Text("Bid 1"),
              Text("Bid 1"),
              Text("Bid 1"),
            ],
          ),
        ),
      ),
    );
  }
}
