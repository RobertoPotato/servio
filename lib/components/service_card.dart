import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/image_container.dart';
import 'package:servio/screens/service_screens/service_detail.dart';

class ServiceCard extends StatelessWidget {
  final service;
  final String categoryTitle;

  ServiceCard(
      {
      @required this.service, this.categoryTitle,
     });

  String getBudget() {
    if (service['budgetMin'] > service['budgetMax']) {
      return "${service['budgetMax']} - ${service['budgetMin']}";
    } else {
      return "${service['budgetMin']} - ${service['budgetMax']}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(

      child: Card(
        elevation: kElevationValue/2,
        child: InkWell(
          onTap: () {
            var user = service['User'];
            print(service['id']);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ServiceDetails(
                  firstName: user['firstName'],
                  lastName: user['lastName'],
                  userId: service['userId'],
                  serviceId: service['id'],
                  categoryTitle: categoryTitle,
                  title: service['title'],
                  description: service['description'],
                  budget: getBudget(),
                  terms: service['terms'],
                  imageUrl: service['imageUrl'],
                  county: service['county'],
                  town: service['town'],
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 130.0,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service['title'],
                          style: kHeadingTextStyle.copyWith(fontSize: 15.0,),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.0,),
                        Text(
                          service['description'],
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.grey[700]),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 1.0,),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ImageContainer(
                          borderRadius: 5.0,
                          imageUrl: service['imageUrl'],
                          height: 110.0,
                          isNetworkImage: true,
                          elevation: 0.0,
                        ),
                        SizedBox(height: 4.0,),
                        Text(getBudget()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
