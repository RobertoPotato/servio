import 'package:flutter/material.dart';
import 'package:servio/constants.dart';

class BidDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 370.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    kExampleNameFemale,
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  background: Image.asset(
                    "images/business_woman.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ];
          },

          body: ListView(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
