import 'package:flutter/material.dart';
import 'package:servio/models/Service.dart';
import 'package:servio/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:servio/screens/my_services_bids.dart';

class MyServices extends StatefulWidget {
  static String id = "myServices";
  //TODO Replace static ID value with one obtained from user information
  @override
  _MyServicesState createState() => _MyServicesState();
}

class _MyServicesState extends State<MyServices> {
  Future<Service> futureService;
  List services;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureService = fetchServices();
  }

  Future<Service> fetchServices() async {
    var url = "$kBaseUrl/v1/services/foruser/$kUserId";

    final response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    final jsonResponse = json.decode(response.body);

    setState(() {
      services = json.decode(response.body);
    });

    if (response.statusCode == 200) {
      return Service.fromJson(jsonResponse[0]);
    } else {
      throw Exception('Failed to load Services');
    }
  }

  String budget(index) {
    if (services[index]['budgetMin'] > services[index]['budgetMax']) {
      return "${services[index]['budgetMax']} - ${services[index]['budgetMin']}";
    } else {
      return "${services[index]['budgetMin']} - ${services[index]['budgetMax']}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Services"),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              print("Service has been clicked");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => MyServicesBids(serviceId: services[index]['id'],),
                ),
              );

              /*Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => JobDetails(
                    userId: services[index]['userId'],
                    serviceId: services[index]['id'],
                    categoryTitle: widget.categoryTitle,
                    title: services[index]['title'],
                    description: services[index]['description'],
                    budget: budget(index),
                    terms: services[index]['terms'],
                    imageUrl: services[index]['imageUrl'],
                    county: mAddress['county'],
                    town: mAddress['town'],
                    lat: mAddress['lat'],
                    long: mAddress['long'],
                  ),
                ),
              );*/
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kMainHorizontalPadding,
                  vertical: kMainHorizontalPadding / 4),
              child: Card(
                elevation: kElevationValue / 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kMainHorizontalPadding,
                      vertical: kMainHorizontalPadding / 2),
                  child: Column(
                    children: <Widget>[
                      Image.network('${services[index]['imageUrl']}'),
                      Text(services[index]['id'].toString()),
                      Text(
                        services[index]['title'],
                        style: kMainBlackTextStyle,
                      ),
                      Text(services[index]['description']),
                      Text(services[index]['imageUrl']),
                      Text(budget(index)),
                      Text("Job Terms: ${services[index]['terms']}"),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: services == null ? 0 : services.length,
      ),
    );
  }
}
