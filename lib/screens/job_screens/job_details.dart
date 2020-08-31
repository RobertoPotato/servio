import 'package:flutter/material.dart';
import 'package:servio/constants.dart';

class JobDetails extends StatefulWidget {
  final client;
  final agent;
  final bid;
  final service;
  final status;
  final jobStart;
  final bool userIsClient;

  const JobDetails(
      {@required this.client,
      @required this.agent,
      @required this.bid,
      @required this.service,
      @required this.status,
      @required this.jobStart,
      //checks if the info coming is from the role of the current user being the client
      @required this.userIsClient});
  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  @override
  Widget build(BuildContext context) {
    _showSnack(BuildContext context, text) {
      final snackBar = SnackBar(
        content: Text(text),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Builder(
            builder: (context) => InkWell(
              onTap: () {
                _showSnack(context,  widget.userIsClient
                    ? 'Agent\'s name: ${widget.agent['firstName']} ${widget.agent['lastName']}'
                    : 'Client\'s name: ${widget.client['firstName']} ${widget.client['lastName']}',);
              },
              child:
              Text(
                  widget.userIsClient
                      ? 'Agent\'s name: ${widget.agent['firstName']} ${widget.agent['lastName']}'
                      : 'Client\'s name: ${widget.client['firstName']} ${widget.client['lastName']}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ),
            ),
          ),
        body: SingleChildScrollView(
          child: Column(
            children: [Text('This here is the details page for the jobs')],
          ),
        ),
      ),
    );
  }
}
