import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:servio/constants.dart';

class RequestServicePage extends StatefulWidget {
  static String id = 'requestService';

  _RequestServicePageState createState() => _RequestServicePageState();
}

class _RequestServicePageState extends State<RequestServicePage> {
  PageController _pageController;
  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormFieldState> _specifyTextFieldKey =
      GlobalKey<FormFieldState>();

  ValueChanged _onChanged = (val) => print(val);

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
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Order a Service'),
        ),
        body: SafeArea(
          child: Center(
            child: FormBuilder(
              key: _fbKey,
              initialValue: {
                'post_date': DateTime.now(),
              },
              child: PageView(
                controller: _pageController,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(kMainHorizontalPadding),
                          child: FormBuilderTextField(
                            attribute: 'county',
                            decoration: InputDecoration().copyWith(
                              hasFloatingPlaceholder: false,
                              hintText: 'County',
                              labelText: 'County',
                              prefixIcon: Icon(Icons.map),
                            ),
                            validators: [FormBuilderValidators.required()],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(kMainHorizontalPadding),
                          child: FormBuilderDropdown(
                            attribute: 'service_category',
                            decoration: InputDecoration().copyWith(
                              prefixIcon: Icon(Icons.category),
                            ),
                            hint: Text('Select Service Category'),
                            validators: [FormBuilderValidators.required()],
                            items: [
                              'Service 1',
                              'Service 2',
                              'Service 3'
                            ] //todo these will be loaded from the services table in the db
                                .map((service) => DropdownMenuItem(
                                      child: Text('$service'),
                                      value: service,
                                    ))
                                .toList(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(kMainHorizontalPadding),
                          child: FormBuilderTextField(
                            attribute: 'service_title',
                            decoration: InputDecoration().copyWith(
                              hintText: 'Title',
                              labelText: 'Title',
                              hasFloatingPlaceholder: false,
                              prefixIcon: Icon(Icons.work),
                            ),
                            validators: [FormBuilderValidators.required()],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(kMainHorizontalPadding),
                          child: FormBuilderDropdown(
                            attribute: 'service_type',
                            decoration: InputDecoration().copyWith(
                              prefixIcon: Icon(Icons.supervisor_account),
                            ),
                            hint: Text('Employment Type'),
                            validators: [FormBuilderValidators.required()],
                            items: ['Part Time', 'Full time', 'Unspecified']
                                .map((service) => DropdownMenuItem(
                                      child: Text('$service'),
                                      value: service,
                                    ))
                                .toList(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(kMainHorizontalPadding),
                          child: FormBuilderTextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 3,
                            attribute: 'service_description',
                            decoration: InputDecoration().copyWith(
                              hasFloatingPlaceholder: false,
                              labelText: 'Description',
                              hintText: 'Describe the service',
                              prefixIcon: Icon(Icons.note_add),
                            ),
                            validators: [FormBuilderValidators.required()],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(kMainHorizontalPadding),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: kMainHorizontalPadding / 2),
                                  child: FormBuilderTextField(
                                    keyboardType: TextInputType.number,
                                    attribute: 'service_duration',
                                    decoration: InputDecoration().copyWith(
                                      hasFloatingPlaceholder: false,
                                      labelText: 'Duration',
                                      hintText: '2/4/7',
                                      prefixIcon: Icon(Icons.access_time),
                                    ),
                                    validators: [
                                      FormBuilderValidators.required()
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: kMainHorizontalPadding / 2),
                                  child: FormBuilderDropdown(
                                    attribute: 'service_duration_time',
                                    decoration: InputDecoration().copyWith(
                                    ),
                                    hint: Text('Select Period'),
                                    validators: [
                                      FormBuilderValidators.required()
                                    ],
                                    items: ['Hours', 'Days', 'Weeks', 'Months']
                                        .map((service) => DropdownMenuItem(
                                              child: Text('$service'),
                                              value: service,
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(kMainHorizontalPadding),
                          child: FormBuilderTextField(
                            keyboardType: TextInputType.number,
                            attribute: 'service_open_positions',
                            decoration: InputDecoration().copyWith(
                              hasFloatingPlaceholder: false,
                              labelText: 'Open Positions',
                              hintText: 'How many positions are available?',
                              prefixIcon: Icon(Icons.person),
                            ),
                            validators: [FormBuilderValidators.required()],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(kMainHorizontalPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: kMainHorizontalPadding / 2),
                                  child: FormBuilderTextField(
                                    keyboardType: TextInputType.number,
                                    attribute: 'price_min',
                                    decoration: InputDecoration().copyWith(
                                      labelText: 'Budget From',
                                      hasFloatingPlaceholder: false,
                                      prefixIcon: Icon(Icons.payment),
                                    ),
                                    validators: [
                                      FormBuilderValidators.required()
                                    ],
                                  ),
                                ),
                              ),
                              Text('To'),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: kMainHorizontalPadding / 2),
                                  child: FormBuilderTextField(
                                    keyboardType: TextInputType.number,
                                    attribute: 'price_max',
                                    decoration: InputDecoration().copyWith(
                                      hasFloatingPlaceholder: false,
                                      labelText: 'Budget To',
                                    ),
                                    validators: [
                                      FormBuilderValidators.required()
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Upload Some Images',
                          style: kHeadingTextStyle.copyWith(
                              color: Colors.grey.shade500),
                        ),
                        FormBuilderImagePicker(
                          attribute: 'service_image',
                          decoration: InputDecoration(border: InputBorder.none),
                          iconColor: kPrimaryColor,
                          validators: [
                            FormBuilderValidators.required(),
                            (images) {
                              if (images.length < 2) {
                                return "Two or more images required";
                              }
                              return null;
                            }
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.send,
            size: 28,
          ),
          onPressed: () {
            if (_fbKey.currentState.saveAndValidate()) {
              print(_fbKey.currentState.value);
            }
          },
        ),
      ),
    );
  }
}
