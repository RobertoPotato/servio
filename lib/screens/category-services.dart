import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:servio/screens/service_screens/service_detail.dart';
import 'package:servio/models/Service.dart';

class CategoryServices extends StatefulWidget {
  final int categoryId;
  final String categoryTitle;

  CategoryServices({this.categoryId, this.categoryTitle});

  @override
  _CategoryServicesState createState() => _CategoryServicesState();
}

class _CategoryServicesState extends State<CategoryServices> {
  Future<Service> futureService;
  List services;

  @override
  void initState() {
    super.initState();
    futureService = fetchServices();
  }

  Future<Service> fetchServices() async {
    var url =
        '$kBaseUrl/v1/services/category/${widget.categoryId}';
    final response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    final jsonResponse = json.decode(response.body);

    setState(() {
      services = json.decode(response.body);
    });

    if (response.statusCode == 200) {
      return Service.fromJson(jsonResponse[0]);
    } else {
      throw Exception('Failed to load categories');
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
        title: Text(widget.categoryTitle),
      ),
      body: ListView.builder(
        itemCount: services == null ? 0 : services.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              var user = services[index]['User'];
              print(services[index]['id']);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ServiceDetails(
                    firstName: user['firstName'],
                    lastName: user['lastName'],
                    userId: services[index]['userId'],
                    serviceId: services[index]['id'],
                    categoryTitle: widget.categoryTitle,
                    title: services[index]['title'],
                    description: services[index]['description'],
                    budget: budget(index),
                    terms: services[index]['terms'],
                    imageUrl: services[index]['imageUrl'],
                    county: services[index]['county'],
                    town: services[index]['town'],
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
                      Image.network(
                          '${services[index]['imageUrl']}'),
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