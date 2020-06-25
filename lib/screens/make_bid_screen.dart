import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:servio/components/card_title_text.dart';
import 'package:servio/components/icon_button_text.dart';

class MakeBidScreen extends StatefulWidget {
  static String id = 'make_bid';

  @override
  _MakeBidScreenState createState() => _MakeBidScreenState();
}

var jobId = 'id of job passed through the navigator';
var jobTitle = 'Title of job being bid for'; //also passed through navigator

class _MakeBidScreenState extends State<MakeBidScreen> {
  PageController _pageController;
  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  /*todo uncomment if needed:
  final GlobalKey<FormFieldState> _specifyTextFieldKey =
      GlobalKey<FormFieldState>();

  ValueChanged _onChanged = (val) => print(val);
  */

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          appBar: AppBar(
            title: Text('$jobTitle'),
          ),
          body: FormBuilder(
            key: _fbKey,
            initialValue: {
              'bid_date': DateTime.now(),
            },
            child: PageView(
              controller: _pageController,
              children: <Widget>[
                SingleChildScrollView(
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
                          attribute: 'bid_amount',
                          decoration: InputDecoration().copyWith(
                            hasFloatingPlaceholder: false,
                            hintText: 'Bid Amount',
                            labelText: 'Amount',
                            prefixIcon: Icon(Icons.monetization_on),
                          ),
                          validators: [FormBuilderValidators.required()],
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
                          attribute: 'cover_letter',
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
                          attribute: 'can_travel',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(kMainHorizontalPadding),
                        child: FormBuilderCheckbox(
                          initialValue: false,
                          label: Text(
                              'I have read and accepted all the client\'s terms'),
                          attribute: 'accept_all',
                          validators: [FormBuilderValidators.requiredTrue()],
                        ),
                      ),
                      IconButtonWithText(
                        text: 'Post',
                        icon: Icons.send,
                        onTap: () {
                          if (_fbKey.currentState.saveAndValidate()) {
                            print(_fbKey.currentState.value);
                          }
                        },
                        materialColor: kMyBidsColor,
                      )
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
