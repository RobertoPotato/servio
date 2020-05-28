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
            ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
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
                  //FIRST FORM PAGE
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        FormBuilderTextField(
                          attribute: 'county',
                          decoration: InputDecoration(
                            labelText: 'County',
                            icon: Icon(Icons.map),
                          ),
                          validators: [FormBuilderValidators.required()],
                        ),
                        FormBuilderDropdown(
                          attribute: 'service_category',
                          decoration: InputDecoration(
                            labelText: 'Category',
                            icon: Icon(Icons.category),
                          ),
                          hint: Text('Select Service Category'),
                          validators: [FormBuilderValidators.required()],
                          items: ['Service 1', 'Service 2', 'Service 3']
                              .map((service) => DropdownMenuItem(
                                    child: Text('$service'),
                                    value: service,
                                  ))
                              .toList(),
                        ),
                        FormBuilderTextField(
                          attribute: 'service_title',
                          decoration: InputDecoration(
                            labelText: 'Title',
                            hintText: 'Develop/Clean/Transport...',
                            icon: Icon(Icons.work),
                          ),
                          validators: [FormBuilderValidators.required()],
                        ),
                        FormBuilderDropdown(
                          attribute: 'service_type',
                          decoration: InputDecoration(
                            labelText: 'Employment Type',
                            icon: Icon(Icons.work),
                          ),
                          hint: Text('Select Type'),
                          validators: [FormBuilderValidators.required()],
                          items: ['Part Time', 'Full time', 'Unspecified']
                              .map((service) => DropdownMenuItem(
                                    child: Text('$service'),
                                    value: service,
                                  ))
                              .toList(),
                        ),
                        FormBuilderTextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          attribute: 'service_description',
                          decoration: InputDecoration(
                            labelText: 'Description',
                            hintText: 'Describe the service',
                            icon: Icon(Icons.note_add),
                          ),
                          validators: [FormBuilderValidators.required()],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: FormBuilderTextField(
                                keyboardType: TextInputType.number,
                                attribute: 'service_duration',
                                decoration: InputDecoration(
                                  labelText: 'Duration',
                                  hintText: '2/4/7',
                                  icon: Icon(Icons.access_time),
                                ),
                                validators: [FormBuilderValidators.required()],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: FormBuilderDropdown(
                                attribute: 'service_duration_time',
                                decoration: InputDecoration(
                                  labelText: 'Period',
                                ),
                                hint: Text('Select Period'),
                                validators: [FormBuilderValidators.required()],
                                items: ['Hours', 'Days', 'Weeks', 'Months']
                                    .map((service) => DropdownMenuItem(
                                          child: Text('$service'),
                                          value: service,
                                        ))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                        FormBuilderTextField(
                          keyboardType: TextInputType.number,
                          attribute: 'service_open_positions',
                          decoration: InputDecoration(
                            labelText: 'Open Positions',
                            hintText: 'How many positions are available?',
                            icon: Icon(Icons.person),
                          ),
                          validators: [FormBuilderValidators.required()],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: FormBuilderTextField(
                                keyboardType: TextInputType.number,
                                attribute: 'price_min',
                                decoration: InputDecoration(
                                  labelText: 'Budget From',
                                  icon: Icon(Icons.payment),
                                ),
                                validators: [FormBuilderValidators.required()],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('To'),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: FormBuilderTextField(
                                keyboardType: TextInputType.number,
                                attribute: 'price_max',
                                decoration: InputDecoration(
                                  labelText: 'Budget To',
                                ),
                                validators: [FormBuilderValidators.required()],
                              ),
                            ),
                          ],
                        ),
                        FormBuilderImagePicker(
                          attribute: 'service_image',
                          decoration: InputDecoration(labelText: 'Images'),
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
                        RaisedButton(
                          child: Text("Submit"),
                          onPressed: () {
                            if (_fbKey.currentState.saveAndValidate()) {
                              print(_fbKey.currentState.value);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  //SECOND FORM PAGE
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
