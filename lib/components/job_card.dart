import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/image_container.dart';
import 'package:servio/screens/job_screens/job_details.dart';

class JobCard extends StatelessWidget {
  final client;
  final agent;
  final bid;
  final service;
  final status;
  final jobStart;
  final int clientId;
  final int agentId;
  final bool userIsClient;
  final int jobId;
  final String token;

  const JobCard(
      {@required this.client,
      @required this.agent,
      @required this.bid,
      @required this.service,
      @required this.status,
      @required this.jobStart,
      @required this.userIsClient,
      @required this.jobId,
      @required this.clientId,
      @required this.agentId,
      @required this.token});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: kMainHorizontalPadding / 3,
          horizontal: kMainHorizontalPadding),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => JobDetails(
                jobId: jobId,
                userIsClient: userIsClient,
                status: status,
                service: service,
                client: client,
                bid: bid,
                agent: agent,
                jobStart: jobStart,
                clientId: clientId,
                agentId: agentId,
                token: token,
              ),
            ),
          );
        },
        child: Card(
          elevation: kElevationValue / 2,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ImageContainer(
                    isNetworkImage: true,
                    elevation: 0.0,
                    borderRadius: 10.0,
                    imageUrl: "$kImageBaseUrl${service['imageUrl']}",
                    height: 90.0,
                  ),
                ),
                SizedBox(
                  width: 4.0,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service['title'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            kHeadingTextStyle.copyWith(color: Colors.grey[700]),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        userIsClient
                            ? 'Agent\'s name: ${agent['firstName']} ${agent['lastName']}'
                            : 'Client\'s name: ${client['firstName']} ${client['lastName']}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: kHeadingSubTextStyle,
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(jobStart),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
