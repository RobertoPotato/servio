import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/screens/alerts_screens/alert_detail.dart';

class AlertCard extends StatelessWidget {
  final int id;
  final String title;
  final String payload;
  final int createdFor;
  final bool isSeen;
  final String type;
  final date;

  AlertCard(
      {@required this.isSeen,
      @required this.title,
      @required this.payload,
      @required this.id,
      @required this.createdFor,
      @required this.type,
      @required this.date});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: kMainHorizontalPadding / 2,
          horizontal: kMainHorizontalPadding),
      child: Card(
        elevation: kElevationValue / 2,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => AlertDetails(
                  isSeen: isSeen,
                  title: title,
                  type: type,
                  createdFor: createdFor,
                  payload: payload,
                  date: date,
                  id: id,
                ),
              ),
            );
          },
          child: ListTile(
            title: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              payload,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Icon(
                isSeen ? Icons.check_box : Icons.check_box_outline_blank,
                size: 28.0,
                color: kPrimaryColor),
          ),
        ),
      ),
    );
  }
}
