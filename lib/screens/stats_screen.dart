import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:servio/models/Stats.dart';
import 'package:servio/components/basic_stats_card.dart';

class StatsPage extends StatefulWidget {
  final String token;
  StatsPage({@required this.token});
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  Future futureStats;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureStats = getUserStats(token: widget.token);
  }

  Future getUserStats({@required String token}) async {
    print("Fetching stats");
    final String url = "$kBaseUrl/v1/statistics/";

    print(url);

    final response = await http.get(Uri.encodeFull(url),
        headers: {"accepts": "application/json", "x-auth-token": token});

    final jsonResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      print("Response caught");
      return Stats.fromJson(jsonResponse);
    } else {
      print("no response");
    }

    return;

    /*if (response.statusCode == 200) {
      var stats = Stats.fromJson(json.decode(response.body));
      print("Response was caught");
      return stats;
    } else {
      return "";
    }*/
  }

  showNumberOrZero(recoveredValue) {
    if (recoveredValue >= 1) {
      return recoveredValue.toStringAsFixed(1);
    } else
      return 0;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.token);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Basic Stats"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: futureStats,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        BasicStats(
                          item: "Bids made",
                          value: "${snapshot.data.bidCount}",
                        ),
                        BasicStats(
                          item: "Times hired",
                          value: "${snapshot.data.jobCount}",
                        ),
                        BasicStats(
                          item: "Jobs completed",
                          value: "${snapshot.data.jobsCompleted}",
                        ),
                        BasicStats(
                          item: "Jobs stalled",
                          value: "${snapshot.data.jobsStalled}",
                        ),
                        BasicStats(
                          item: "Jobs Created",
                          value: "${snapshot.data.jobsCreated}",
                        ),
                        BasicStats(
                          item: "Total services",
                          value: "${snapshot.data.servicesCount}",
                        ),
                        BasicStats(
                          item: "Bidding success rate",
                          value:
                              "${showNumberOrZero((snapshot.data.jobCount / snapshot.data.bidCount))}",
                        ),
                        BasicStats(
                          item: "Job completion rate",
                          value:
                              "${showNumberOrZero((snapshot.data.jobsCompleted / snapshot.data.jobCount))}",
                        ),
                      ],
                    );
                  } else if (snapshot.hasData) {
                    return Text("Error");
                  }
                  return Center(child: CircularProgressIndicator());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
