import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:servio/components/card_title_text.dart';
import 'package:servio/components/icon_button_text.dart';
import 'package:http/http.dart' as http;
import 'package:servio/models/Bid.dart';
import 'dart:convert';
import 'package:servio/jwt_helpers.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:servio/screens/errors/error_screen.dart';

final storage = FlutterSecureStorage();

class MakeBidScreen extends StatefulWidget {
  final int serviceId;
  final int userId;
  final String serviceTitle;
  final String serviceCategory;

  MakeBidScreen(
      {@required this.serviceId,
      @required this.userId,
      @required this.serviceTitle,
      @required this.serviceCategory});

  @override
  _MakeBidScreenState createState() => _MakeBidScreenState();
}

Future<Bid> createBid(
    String token,
    double amount,
    String coverLetter,
    bool canTravel,
    String availability,
    String currency,
    int userId,
    int serviceId) async {
  final String url = "$kBaseUrl/v1/bids/";
  final response = await http.post(Uri.encodeFull(url),
      body: json.encode({
        "amount": amount,
        "coverLetter": coverLetter,
        "canTravel": canTravel,
        "availability": availability,
        "currency": currency,
        "serviceId": serviceId,
      }),
      //necessary for transporting json to server. Specify what data is being sent
      headers: {
        "accept": "application/json",
        "content-type": "application/json",
        "x-auth-token": "$token"
      });

  if (response.statusCode == 201) {
    final String responseString = response.body;
    return bidFromJson(responseString);
  } else {
    return null;
  }
}

class _MakeBidScreenState extends State<MakeBidScreen> {
  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Your Progress will be lost'),
        content: Text('Do you really want to exit?'),
        actions: <Widget>[
          FlatButton(
            child: Text('Continue'),
            onPressed: () => Navigator.pop(context, false),
          ),
          FlatButton(
            child: Text('Exit'),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _showSnack(BuildContext context) {
      final snackBar = SnackBar(
        content: Text("${widget.serviceTitle}"),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }

    return SafeArea(
      child: WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          appBar: AppBar(
            title: Builder(
              builder: (context) => InkWell(
                onTap: () {
                  _showSnack(context);
                },
                child:
                    Text('${widget.serviceCategory}: ${widget.serviceTitle}'),
              ),
            ),
          ),
          body: FutureBuilder(
            future: jwtOrEmpty,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              if (snapshot.data != "") {
                return FormBuilder(
                  key: _fbKey,
                  initialValue: {
                    'bid_date': DateTime.now(),
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        CardWithTitleAndText(
                          title: 'Notice',
                          text: '$kBidNotice',
                        ),
                        Padding(
                          padding: const EdgeInsets.all(kMainHorizontalPadding),
                          child: FormBuilderTextField(
                            keyboardType: TextInputType.number,
                            attribute: 'amount',
                            decoration: InputDecoration().copyWith(
                              hasFloatingPlaceholder: false,
                              hintText: 'Bid Amount',
                              labelText: 'Amount',
                              prefixIcon: Icon(Icons.monetization_on),
                            ),
                            validators: [
                              FormBuilderValidators.required(),
                              FormBuilderValidators.numeric()
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(kMainHorizontalPadding),
                          child: FormBuilderDropdown(
                            attribute: 'availability',
                            decoration: InputDecoration().copyWith(
                              prefixIcon: Icon(Icons.access_time),
                            ),
                            hint: Text('Select your availability'),
                            validators: [FormBuilderValidators.required()],
                            items: [
                              'Hourly',
                              'Daily',
                              'When Needed',
                            ]
                                .map((availability) => DropdownMenuItem(
                                      child: Text('$availability'),
                                      value: availability,
                                    ))
                                .toList(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(kMainHorizontalPadding),
                          child: FormBuilderTextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            attribute: 'coverLetter',
                            decoration: InputDecoration().copyWith(
                              hasFloatingPlaceholder: false,
                              labelText: 'Cover Letter',
                              hintText: 'Describe what you have to offer',
                              prefixIcon: Icon(Icons.mail),
                            ),
                            validators: [FormBuilderValidators.required()],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(kMainHorizontalPadding),
                          child: FormBuilderCheckbox(
                            initialValue: false,
                            label: Text('Can Travel'),
                            attribute: 'canTravel',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(kMainHorizontalPadding),
                          child: FormBuilderCheckbox(
                            initialValue: false,
                            label: Text(
                                'I have read and accepted all the client\'s terms'),
                            attribute: 'acceptAll',
                            validators: [FormBuilderValidators.requiredTrue()],
                          ),
                        ),
                        IconButtonWithText(
                          text: 'Post',
                          icon: Icons.send,
                          onTap: () async {
                            if (_fbKey.currentState.saveAndValidate()) {
                              //use the addAll method to combine them
                              final formData = _fbKey.currentState.value;

                              final double amount = double.parse(formData[
                                  'amount']); //convert the value from string to double
                              final String coverLetter =
                                  formData['coverLetter'];
                              final bool canTravel = formData['canTravel'];
                              final String availability =
                                  formData['availability'];
                              final String currency =
                                  kExampleCurrency /*TODO Uncomment This to avoid using default -> formData['currency']*/;
                              final int userId = widget.userId;
                              final int serviceId = widget.serviceId;

                              //createBid();
                              createBid(
                                  snapshot.data,
                                  amount.toDouble(),
                                  coverLetter,
                                  canTravel,
                                  availability,
                                  currency,
                                  userId,
                                  serviceId);
                            }
                          },
                          materialColor: kMyBidsColor,
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return ErrorScreen(
                  message: "Invalid Token",
                  errorImage: kErrorImage,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
