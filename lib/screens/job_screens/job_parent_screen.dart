import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/screens/job_screens/awarded_jobs.dart';
import 'package:servio/screens/job_screens/created_jobs.dart';

class JobParentScreen extends StatefulWidget {
  static String id = 'jobParentScreen';
  final String token;

  const JobParentScreen({@required this.token});

  @override
  _JobParentScreen createState() => _JobParentScreen();
}

class _JobParentScreen extends State<JobParentScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedIndex == 0
          ? CreatedJobs(
              loggedInUserId: kUserId,
              token: widget.token,
            )
          : AwardedJobs(
              loggedInUserId: kUserId,
              token: widget.token,
            ),

      //body will be whatever screen is represented by the index
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kPrimaryColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.all_out),
            label: 'Mine',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_paint),
            label: 'Applied',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kScaffoldBackgroundColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
