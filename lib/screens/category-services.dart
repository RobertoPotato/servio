import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:servio/screens/service_screens/service_detail.dart';

class Service {
  final int id;
  final String title;
  final String description;
  final double budgetMin;
  final double budgetMax;
  final String terms;
  final String imageUrl;
  final int userId;
  final int categoryId;
  final int statusId;
  final String createdAt;
  final address;

  Service(
      {this.id,
      this.title,
      this.description,
      this.budgetMin,
      this.budgetMax,
      this.terms,
      this.imageUrl,
      this.userId,
      this.categoryId,
      this.statusId,
      this.createdAt,
      this.address});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      budgetMin: json['budgetMin'],
      budgetMax: json['budgetMax'],
      terms: json['terms'],
      imageUrl: json['imageUrl'],
      userId: json['userId'],
      categoryId: json['categoryId'],
      statusId: json['statusId'],
      createdAt: json['createdAt'],
      address: json['Address'],
    );
  }
}

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
    // TODO: implement initState
    super.initState();
    futureService = fetchServices();
  }

  Future<Service> fetchServices() async {
    var url =
        '$kBaseUrl/v1/services/address/${widget.categoryId}';
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
        itemBuilder: (BuildContext context, int index) {
          var mAddress = services[index]['Address'];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ServiceDetails(
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
              );
              print(
                  "Town: ${mAddress['town']}, county: ${mAddress['county']}, lat: ${ mAddress['lat']}, long: ${mAddress['long']}");
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
        itemCount: services == null ? 0 : services.length,
      ),
    );
  }
}

//TODO don't show service items that dont have an address value.
//TODO these can be given an inactive status id and ignored when doing a fetch
