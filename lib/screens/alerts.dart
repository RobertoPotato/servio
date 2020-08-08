import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/screens/alert_screens/jobs_tab.dart';
import 'package:servio/screens/alert_screens/bids_tab.dart';
import 'package:servio/screens/alert_screens/info_tab.dart';

/*
* This page will show alerts (jobs that have been posted)
* in a particular category that a certain user has been
* subscribed to.
* jobs.categories == agent.skill*/
class AlertsScreen extends StatefulWidget {
  static String id = 'alerts';

  @override
  _AlertsScreenState createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  var hasBidAlert = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: <Widget>[
                Tab(text: kBids),
                Tab(text: kInformation),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              //BIDS TAB
              BidsTab(),
              //ALERTS TAB
              InfoTab()
            ],
          ),
        ),
      ),
    );
  }
}
