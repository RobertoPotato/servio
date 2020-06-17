import 'package:flutter/material.dart';
import 'package:servio/components/info_card.dart';

class InfoTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          InfoCard(),
          InfoCard(),
          InfoCard(),
          InfoCard(),
          InfoCard(),
        ],
      ),
    );
  }
}
