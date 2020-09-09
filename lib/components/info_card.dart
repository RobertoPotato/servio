import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/screens/alerts_screens/alert_detail.dart';

class InfoCard extends StatelessWidget {
  final bool isSeen;

  InfoCard({@required this.isSeen});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kMainHorizontalPadding / 2, horizontal: kMainHorizontalPadding),
      child: Card(
        elevation: kElevationValue/2,
        child: InkWell(
          onTap: (){
            print("List item clicked");
            Navigator.pushNamed(context, AlertDetails.id);
          },
          child: ListTile(
            title: Text(kLoremIpsumShort, maxLines: 2, overflow: TextOverflow.ellipsis,),
            subtitle: Text(kLoremIpsum, maxLines: 2, overflow: TextOverflow.ellipsis,),
            trailing: Icon(isSeen ? Icons.check_box : Icons.check_box_outline_blank, size: 34.0, color: kPrimaryColor),
          ),
        ),
      ),
    );
  }
}
