import 'package:flutter/material.dart';
import 'package:servio/components/bid_card.dart';

class BidsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          BidCard(),
          BidCard(),
          BidCard(),
          BidCard(),
        ],
      ),
    );
  }
}
