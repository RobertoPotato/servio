import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/models/Job.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:servio/components/job_card.dart';


class AwardedJobs extends StatefulWidget {
  final String token;
  final int loggedInUserId;

  const AwardedJobs({@required this.loggedInUserId, @required this.token});
  @override
  _AwardedJobsState createState() => _AwardedJobsState();
}

class _AwardedJobsState extends State<AwardedJobs> {
  Future<Job> futureJobs;
  List jobs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureJobs = fetchJobs();
  }

  Future<Job> fetchJobs() async {
    /* The 2 in this route is useless but removing it will cause it to fail
     * on the server side
    */
    var url = "$kBaseUrl/v1/jobs/foragent/2";
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

  //for budget conversions use the budget function located in constants

  @override
  Widget build(BuildContext context) {
    print("Awarded jobs: ${widget.token}");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Awarded to me...'),
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

              //In this page, the user assumes the role of the agent
              return JobCard(
                token: widget.token,
                userIsClient: false,
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
