import 'package:flutter/material.dart';
import 'package:servio/components/bid_card.dart';
import 'package:servio/constants.dart';

class BidScreen extends StatefulWidget {
  static String id = 'bids';
  @override
  _BidScreenState createState() => _BidScreenState();
}

class _BidScreenState extends State<BidScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Bids'), //todo show job title
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kMainHorizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              BidCard(),
              BidCard(),
              BidCard(),
            ],
          ),
        )
      ),
    );
  }
}
