import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:servio/models/Service.dart';
import 'package:servio/components/service_card.dart';

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
    var url = '$kBaseUrl/v1/services/category/${widget.categoryId}';
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
        title: Text(widget.categoryTitle),
      ),
      body: ListView.builder(
        itemCount: services == null ? 0 : services.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(
                left: kMainHorizontalPadding,
                right: kMainHorizontalPadding,
                top: kMainHorizontalPadding),
            child: ServiceCard(
              service: services[index],
              categoryTitle: widget.categoryTitle,
            ),
          );
        },
      ),
    );
  }
}
