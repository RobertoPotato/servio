import 'package:flutter/material.dart';
import 'material_text.dart';
import 'package:servio/constants.dart';
import 'divider_component.dart';

class GridDetailsCard extends StatelessWidget {
  const GridDetailsCard(
      {@required this.row1col1,
      @required this.row1col2,
      @required this.row2col1,
      @required this.row2col2});

  final row1col1;
  final row1col2;
  final row2col1;
  final row2col2;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: kElevationValue / 2,
      child: Padding(
        padding: const EdgeInsets.all(kMainHorizontalPadding),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: MaterialText(
                    text: '$row1col1',
                  ),
                  flex: 1,
                ),
                DividerComponent(
                  height: 10.0,
                ),
                Expanded(
                  child: MaterialText(
                    text: '$row1col2',
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
                    text: '$row2col1',
                  ),
                  flex: 1,
                ),
                DividerComponent(
                  height: 10.0,
                ),
                Expanded(
                  child: MaterialText(
                    text: '$row2col2',
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
