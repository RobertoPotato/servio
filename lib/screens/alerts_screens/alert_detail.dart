import 'package:flutter/material.dart';

class AlertDetails extends StatelessWidget {
  static String id = 'infoDetail';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Info Sender'),
        ),
        body: Text("Info on the alert")
      ),
    );
  }
}
