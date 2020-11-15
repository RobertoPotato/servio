import 'package:flutter/material.dart';
import 'package:servio/components/image_container.dart';
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
      body: services == null
          ? Center(
              child: Text("Looking for your services"),
            )
          : services.length == 0
              ? Center(child: Text(kNoServicesRequestedPrompt))
              : ListView.builder(
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
                            vertical: kMainHorizontalPadding / 2),
                        child: Card(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          services[index]['title'],
                                          style: kHeadingTextStyle.copyWith(
                                            fontSize: 15.0,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 4.0,
                                        ),
                                        Text(
                                          services[index]['description'],
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.grey[700]),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 1.0,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        ImageContainer(
                                          borderRadius: 5.0,
                                          imageUrl:
                                              "$kImageBaseUrl${services[index]['imageUrl']}",
                                          height: 110.0,
                                          isNetworkImage: true,
                                          elevation: 0.0,
                                        ),
                                        SizedBox(
                                          height: 4.0,
                                        ),
                                        Text(
                                          budget(index),
                                        ),
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
                  },
                ),
    );
  }
}
