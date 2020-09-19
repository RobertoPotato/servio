import 'package:flutter/material.dart';
import 'package:servio/components/alert_card.dart';
import 'package:servio/constants.dart';
import 'package:servio/models/Alert.dart';
import 'package:servio/screens/service_screens/request_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:servio/components/top_categories.dart';
import 'package:servio/components/hiring.dart';
// todo uncomment when needed: import 'package:servio/components/search_delegate.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home';
  final String token;

  const HomeScreen({@required this.token});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Alert> futureAlerts;
  List alerts;
  bool listOfAlertsIsAvailable = false;

  @override
  void initState() {
    super.initState();
    futureAlerts = fetchAlerts();
  }

  Future<Alert> fetchAlerts() async {
    var url = "$kBaseUrl/v1/alerts/mine";
    final response = await http.get(Uri.encodeFull(url),
        headers: {"Accept": "application/json", "x-auth-token": widget.token});

    final jsonResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        listOfAlertsIsAvailable = true;
        alerts = json.decode(response.body);
      });

      return Alert.fromJson(jsonResponse[0]);
    } else {
      throw Exception('Failed to load Alerts');
    }
  }

  @override
  Widget build(BuildContext context) {
    //print(alerts);
    return Scaffold(
      appBar: AppBar(
        elevation: kElevationValue,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black54,
              size: 30,
            ),
            onPressed: () {
              //todo implement search functionality
              //showSearch(context: context, delegate: ServiceSearchDelegate());
            },
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black54,
              size: 36,
            ),
            onPressed: () {
              Navigator.pushNamed(context, RequestServicePage.id);
            },
          ),
        ],
        //elevation: kElevationValue,
        title: Text(
          'Home',
          style: kAppBarTitle,
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: TopCategories(),
          ),
          SliverToBoxAdapter(
            child: NowHiring(),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(kMainHorizontalPadding),
              child: Text(
                'Your Alerts',
                style: kHeadingTextStyle,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          listOfAlertsIsAvailable
              ? SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => AlertCard(
                            isSeen: alerts[index]["isSeen"],
                            title: alerts[index]["title"],
                            payload: alerts[index]["payload"],
                            id: alerts[index]["id"],
                            date: alerts[index]["createdAt"],
                            type: alerts[index]["type"],
                            createdFor: alerts[index]["createdFor"],
                            token: widget.token,
                          ),
                      childCount: alerts == null ? 0 : alerts.length),
                )
              : SliverToBoxAdapter(
                  child: Center(
                    child: Text("No new alerts", style: kTestTextStyleBlack,),
                  ),
                ),
        ],
      ),
    );
  }
}
