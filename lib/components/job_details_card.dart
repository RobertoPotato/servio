import 'package:flutter/material.dart';
import 'material_text.dart';
import 'package:servio/constants.dart';
import 'my_vertical_divider.dart';

class JobDetailsCard extends StatelessWidget {
  const JobDetailsCard({this.duration, this.openPositions, this.budgetRange, this.jobTerms}) ;

  final duration;
  final openPositions;
  final budgetRange;
  final jobTerms;

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
                    text: '$duration',
                  ),
                  flex: 1,
                ),
                MyVerticalDivider(height: 10.0,),
                Expanded(
                  child: MaterialText(
                    text: '$openPositions Open Position(s)',
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
                    text: '$jobTerms',
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