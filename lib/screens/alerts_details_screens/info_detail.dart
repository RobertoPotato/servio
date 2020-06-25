import 'package:flutter/material.dart';
import 'package:servio/components/card_title_text.dart';
import 'package:servio/constants.dart';

class InfoDetailsScreen extends StatelessWidget {
  static String id = 'infoDetail';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Info Sender'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kMainHorizontalPadding, vertical: kMainHorizontalPadding/2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: kMainHorizontalPadding),
                  child: CardWithTitleAndText(title: 'Subject', text: kLoremIpsumShort,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: kMainHorizontalPadding),
                  child: CardWithTitleAndText(title: 'Details', text: kLoremIpsum,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
