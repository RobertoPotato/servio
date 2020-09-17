import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/models/Job.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:servio/components/job_card.dart';

//find all jobs for which the current logged in user is the client
//filter them by status ie Ongoing/active, pending and complete
//default filter will be the active one. Others can be selected when needed.
class CreatedJobs extends StatefulWidget {
  final int loggedInUserId;
  final String token;

  const CreatedJobs({@required this.loggedInUserId, @required this.token});

  @override
  _CreatedJobsState createState() => _CreatedJobsState();
}

class _CreatedJobsState extends State<CreatedJobs> {
  Future<Job> futureJobs;
  List jobs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureJobs = fetchJobs();
  }

  Future<Job> fetchJobs() async {
    var url = "$kBaseUrl/v1/jobs/client/2";
    final response = await http.get(Uri.encodeFull(url),
        headers: {"Accept": "application/json", "x-auth-token": widget.token});

    final jsonResponse = json.decode(response.body);

    setState(() {
      jobs = json.decode(response.body);
    });

    if (response.statusCode == 200) {
      return Job.fromJson(jsonResponse[0]);
    } else {
      throw Exception('Failed to load my jobs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Posted by me...'),
        ),
        body: ListView.builder(
            itemCount: jobs == null ? 0 : jobs.length,
            itemBuilder: (BuildContext context, int index) {
              var jobStart = jobs[index]['createdAt'];
              var client = jobs[index]['client'];
              var agent = jobs[index]['agent'];
              var bid = jobs[index]['Bid'];
              var service = jobs[index]['Service'];
              var status = jobs[index]['Status'];
              var clientId = jobs[index]['clientId'];
              var agentId = jobs[index]['agentId'];
              var jobId = jobs[index]['id'];

              //In this page, the user assumes the role of the client
              return JobCard(
                userIsClient: true,
                client: client,
                agent: agent,
                bid: bid,
                status: status,
                jobStart: jobStart,
                service: service,
                clientId: clientId,
                agentId: agentId,
                jobId: jobId,
              );
            }),
      ),
    );
  }
}
