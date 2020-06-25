import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/material_text.dart';
import 'package:servio/components/my_divider.dart';
import 'package:servio/screens/alerts_details_screens/info_detail.dart';

class InfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kMainHorizontalPadding,
          vertical: kMainHorizontalPadding / 2),
      child: Card(
        elevation: kElevationValue / 2,
        child: Padding(
          padding: const EdgeInsets.all(kMainHorizontalPadding / 2),
          child: InkWell(
            onTap: (){
              //todo add the data to be passed through
              Navigator.pushNamed(context, InfoDetailsScreen.id);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: MaterialText(
                        text: 'Sender: ADMIN',
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Subject: $kLoremIpsumShort',
                      ),
                    ),
                  ],
                ),
                MyDivider(thickness: 1.0,),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'DETAILS: $kLoremIpsumShort',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
