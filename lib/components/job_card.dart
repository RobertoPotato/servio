import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'material_text.dart';
import 'package:servio/components/my_divider.dart';
import 'package:servio/screens/alerts_details_screens/job_detail.dart';

class JobCard extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: kMainHorizontalPadding / 2,
          horizontal: kMainHorizontalPadding),
      child: Card(
        elevation: kElevationValue / 2,
        child: Padding(
          padding: const EdgeInsets.all(kMainHorizontalPadding / 2),
          child: InkWell(
            onTap: (){
              //Navigator.pushNamed(context, JobDetails.id);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        kExampleCompanyName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: kHeadingTextStyle.copyWith(
                            color: Colors.grey.shade700),
                      ),
                    ),
                    Row(children: <Widget>[
                      Icon(Icons.star, color: kPrimaryColor,),
                      Text(
                        kExampleRatingText.toString(),
                      ),
                    ],),
                  ],
                ),
                MyDivider(
                  thickness: 1.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'JOB TITLE: $kLoremIpsumShort',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    MaterialText(text: 'Category 1'),
                  ],
                ),
                MyDivider(
                  thickness: 1.0,
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Job Description',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
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
