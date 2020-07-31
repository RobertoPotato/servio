import 'package:flutter/material.dart';
import 'package:servio/screens/demo_http.dart';
import 'package:servio/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Service {
  final int id;
  final String title;
  final String description;
  final double budget;
  final String terms;
  final String imageUrl;
  final int userId;
  final int categoryId;
  final int statusId;
  final String createdAt;

  Service(
      {this.id,
      this.title,
      this.description,
      this.budget,
      this.terms,
      this.imageUrl,
      this.userId,
      this.categoryId,
      this.statusId,
      this.createdAt});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      budget: json['budget'],
      terms: json['terms'],
      imageUrl: json['imageUrl'],
      userId: json['userId'],
      categoryId: json['categoryId'],
      statusId: json['statusId'],
      createdAt: json['createdAt'],
    );
  }
}

class CategoryServices extends StatefulWidget {
  final int mId;

  CategoryServices({this.mId});
  @override
  _CategoryServicesState createState() => _CategoryServicesState();
}

class _CategoryServicesState extends State<CategoryServices> {
  Future<Service> futureService;
  List services;
  var categoryId = 4;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureService = fetchServices();
  }

  Future<Service> fetchServices() async {
    var url = 'http://192.168.100.39:3000/api/v1/services/fromcategory/${widget.mId}';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Services"),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              print(
                  "selected item: ${services[index]['id']}"); //show the id of the item that has been clicked in the terminal
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
                      Text(services[index]['id'].toString()),
                      Text(services[index]['title']),
                      Text(services[index]['description']),
                      Text(services[index]['imageUrl']),
                      Text(services[index]['budget'].toString()),
                      Text(services[index]['terms']),
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
