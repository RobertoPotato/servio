import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:servio/constants.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:servio/models/ErrorResponse.dart';

var parser = EmojiParser();

class CreateReview extends StatefulWidget {
  final token;
  final String name;
  final int jobId;
  final bool userIsClient;

  const CreateReview(
      {@required this.token,
      @required this.name,
      @required this.jobId,
      @required this.userIsClient});

  @override
  _CreateReviewState createState() => _CreateReviewState();
}

class _CreateReviewState extends State<CreateReview> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  double sliderValue = 2.5;
  var min = 0.0;
  var max = 5.0;
  var divisions = 50;

  Future sendReview(
      {double stars,
      String content,
      int jobId,
      String token,
      bool userIsClient}) async {
    print(
        "Stars: $stars \nContent: $content \nJobId: $jobId \nToken: $token \nUser is client: $userIsClient");
    final url = "$kBaseUrl/v1/reviews";

    var response = await http.post(Uri.encodeFull(url),
        body: json.encode({
          "stars": stars.toString(),
          "content": content,
          "jobId": jobId.toString(),
          "userIsClient": userIsClient
        }),
        headers: {
          "accept": "application/json",
          "content-type": "application/json",
          "x-auth-token": token
        });

    var jsonResponse = json.decode(response.body);

    //Handle the errors
    if (response.statusCode == 200) {
      print("Everything's okay");
    } else if (response.statusCode == 400) {
      var error = Error.fromJson(jsonResponse);
      print(error.error.toString());
    } else
      return;
  }

  @override
  Widget build(BuildContext context) {
    print("createReview: User is client: ${widget.userIsClient}");
    return Container(
      width: 300.0,
      height: 350.0,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: kMainHorizontalPadding,
                  right: kMainHorizontalPadding,
                  bottom: kMainHorizontalPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.name}",
                    style: kHeadingTextStyle,
                  ),
                  Text(
                    "${emojiToShow(sliderValue)}",
                    style: TextStyle(fontSize: 30.0),
                  )
                ],
              ),
            ),
            FormBuilder(
              key: _fbKey,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: kMainHorizontalPadding,
                    right: kMainHorizontalPadding,
                    bottom: kMainHorizontalPadding),
                child: Column(
                  children: [
                    Slider(
                      label: sliderValue.toStringAsFixed(1),
                      activeColor: kPrimaryColor,
                      min: min,
                      max: max,
                      value: sliderValue,
                      onChanged: (value) {
                        setState(() {
                          sliderValue = value;
                        });
                      },
                      divisions: divisions,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Rated: ${sliderValue.toStringAsFixed(1)}',
                        style: kHeadingSubTextStyle,
                      ),
                    ),
                    FormBuilderTextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      attribute: 'reviewText',
                      decoration: InputDecoration().copyWith(
                        hasFloatingPlaceholder: false,
                        labelText: 'Leave a review',
                        hintText: 'Review',
                        prefixIcon: Icon(Icons.rate_review),
                      ),
                      validators: [
                        FormBuilderValidators.required(
                            errorText: "Please leave a review")
                      ],
                    ),
                  ],
                ),
              ),
            ),
            FlatButton(
              onPressed: () async {
                if (_fbKey.currentState.saveAndValidate()) {
                  final formData = _fbKey.currentState.value;
                  final String reviewText = formData['reviewText'];
                  print(formData);
                  //TODO ensure slider value gets passed in as part of the review
                  sendReview(
                      stars: sliderValue,
                      content: reviewText,
                      jobId: widget.jobId,
                      token: widget.token,
                      userIsClient: widget.userIsClient);
                }
              },
              color: kPrimaryColor,
              child: Text(
                "Send",
                style: kTestTextStyleWhite,
              ),
            )
          ],
        ),
      ),
    );
  }
}

emojiToShow(double val) {
  var verySatisfied = '😀';
  var satisfied = '😊';
  var neutral = '😐';
  var dissatisfied = '😧';
  var veryDissatisfied = '😣';

  if (val <= 1) {
    return veryDissatisfied;
  } else if (val <= 2) {
    return dissatisfied;
  } else if (val <= 3) {
    return neutral;
  } else if (val <= 4) {
    return satisfied;
  } else if (val <= 5) {
    return verySatisfied;
  } else
    return Icons.error;
}
