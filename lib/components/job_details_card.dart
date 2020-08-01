import 'package:flutter/material.dart';
import 'material_text.dart';
import 'package:servio/constants.dart';
import 'my_vertical_divider.dart';

class JobDetailsCard extends StatelessWidget {
  const JobDetailsCard({this.county, this.town, this.budgetRange, this.terms}) ;

  final county;
  final town;
  final budgetRange;
  final terms;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: kElevationValue/2,
      child: Padding(
        padding: const EdgeInsets.all(kMainHorizontalPadding),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: MaterialText(
                    text: '$county County',
                  ),
                  flex: 1,
                ),
                MyVerticalDivider(height: 10.0,),
                Expanded(
                  child: MaterialText(
                    text: '$town Town',
                  ),
                  flex: 1,
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: MaterialText(
                    text: 'Ksh $budgetRange',
                  ),
                  flex: 1,
                ),
                MyVerticalDivider(height: 10.0,),
                Expanded(
                  child: MaterialText(
                    text: '$terms',
                  ),
                  flex: 1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}