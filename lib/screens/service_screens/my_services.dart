import 'package:flutter/material.dart';
import 'package:servio/models/Service.dart';
import 'package:servio/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:servio/screens/service_screens/my_services_bids.dart';

class MyServices extends StatefulWidget {
  static String id = "myServices";
  final String token;

  const MyServices({@required this.token});
  @override
  _MyServicesState createState() => _MyServicesState();
}

class _MyServicesState extends State<MyServices> {
  Future<Service> futureService;
  List services;

  @override
  void initState() {
    super.initState();
    futureService = fetchServices();
  }

  Future<Service> fetchServices() async {
    var url = "$kBaseUrl/v1/services/foruser/999";

    final response = await http.get(Uri.encodeFull(url),
        headers: {"Accept": "application/json", "x-auth-token": widget.token});

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
        itemCount: services == null ? 0 : services.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => MyServicesBids(
                    serviceId: services[index]['id'],
                    token: widget.token,
                  ),
                ),
              );
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
      ),
    );
  }
}
