import 'package:flutter/material.dart';
import 'package:servio/components/job_card.dart';

class JobsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              JobCard(),
              JobCard(),
              JobCard(),
              JobCard(),
            ],
          ),
        ),
      ),
    );
  }
}
