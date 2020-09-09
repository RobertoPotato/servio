import 'package:flutter/material.dart';
import 'package:servio/components/info_card.dart';

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
        child: Scaffold(
          appBar: AppBar(
           title: Text("Info"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                InfoCard(isSeen: false,),
                InfoCard(isSeen: false,),
                InfoCard(isSeen: true,),
                InfoCard(isSeen: true,),
                InfoCard(isSeen: true,),
              ],
            ),
          )
        ),
    );
  }
}
