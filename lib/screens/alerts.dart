import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/bid_card.dart';

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
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: <Widget>[
                Tab(text: kJobs),
                Tab(text: kBids),
                Tab(text: kAnnouncements),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              //FIRST TAB
              Column(
                children: <Widget>[
                  Center(
                    child: Text('Jobs Tab'),
                  )
                ],
              ),
              //SECOND TAB
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    BidCard(),
                    BidCard(),
                    BidCard(),
                    BidCard(),
                  ],
                ),
              ),
              //THIRD TAB
              Column(
                children: <Widget>[
                  Center(
                    child: Text('Announcements Tab'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
