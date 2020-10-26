import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:servio/components/icon_button_text.dart';
import 'package:servio/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:servio/jwt_helpers.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:servio/models/CategoryWithIdAndTitle.dart';
import 'package:servio/screens/errors/error_screen.dart';
import 'package:servio/screens/profile_screens/profile_helpers.dart';
import 'package:servio/components/material_text.dart';
import 'list_of_counties.dart';
import 'package:servio/screens/service_screens/service_helpers.dart';

final storage = FlutterSecureStorage();

class RequestServicePage extends StatefulWidget {
  static String id = 'requestService';

  _RequestServicePageState createState() => _RequestServicePageState();
}

class Category {
  final int id;
  final String title;
  Category({@required this.id, @required this.title});
}

class _RequestServicePageState extends State<RequestServicePage> {
  var data;
  List categories;
  Future<CategoryIdAndTitle> futureCategories;
  File imageFile;
  var token;

  @override
  void initState() {
    super.initState();
    futureCategories = getCategoriesForDropDown();
  }

  Future<CategoryIdAndTitle> getCategoriesForDropDown() async {
    //the zero has no use whatsoever but code works if it's there
    var url = "$kBaseUrl/v1/categories/items/0";
    final response = await http
        .get(Uri.encodeFull(url), headers: {"accept": "application/json"});

    //final jsonResponse = json.decode(response.body);

    setState(() {
      categories = json.decode(response.body);
    });

    if (response.statusCode == 200) {
      var categories =  CategoryIdAndTitle.fromJson(json.decode(response.body));
      return categories;
    } else {
      throw Exception("Error fetching categories");
    }
  }

  Future _getImageGallery() async {
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = File(pickedFile.path);
    });
    Navigator.of(context).pop();
  }

  Future _getImageCamera() async {
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = File(pickedFile.path);
    });
    Navigator.of(context).pop();
  }

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

  //TODO Add this to review card = pop scope handling
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
              child: SingleChildScrollView(
                child: FutureBuilder(
                    future: jwtOrEmpty,
                    builder: (context, jwtSnapshot) {
                      if (!jwtSnapshot.hasData)
                        return CircularProgressIndicator();
                      if (jwtSnapshot.data != "") {
                        return FutureBuilder(
                          future: profileOrEmpty,
                          builder: (context, profileSnapshot) {
                            return Column(
                              children: <Widget>[
                                profileSnapshot.data == ''
                                    ? MaterialText(
                                        text:
                                            "Please set up your profile first",
                                        fontStyle: kTestTextStyleWhite,
                                        color: kRedAlert,
                                      )
                                    : Text(""),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: kMainHorizontalPadding,
                                      right: kMainHorizontalPadding,
                                      top: kMainHorizontalPadding),
                                  child: FormBuilderTextField(
                                    attribute: 'title',
                                    decoration: InputDecoration().copyWith(
                                      hintText: 'Title',
                                      labelText: 'Title',
                                      prefixIcon: Icon(Icons.work),
                                    ),
                                    validators: [
                                      FormBuilderValidators.required()
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: kMainHorizontalPadding,
                                      right: kMainHorizontalPadding,
                                      top: kMainHorizontalPadding),
                                  child: FormBuilderDropdown(
                                    attribute: 'categoryId',
                                    decoration: InputDecoration().copyWith(
                                      prefixIcon: Icon(Icons.category),
                                    ),
                                    hint: Text('Select Service Category'),
                                    validators: [
                                      FormBuilderValidators.required()
                                    ],
                                    //TODO handle nulls by having a default fallback category like "Others" or "Default" eg ID 99
                                    items: categories
                                        .map(
                                          (category) => DropdownMenuItem(
                                            child: Text(category['title']),
                                            value: category['id'],
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: kMainHorizontalPadding,
                                      right: kMainHorizontalPadding,
                                      top: kMainHorizontalPadding),
                                  child: FormBuilderTextField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 7,
                                    attribute: 'description',
                                    decoration: InputDecoration().copyWith(
                                      //hasFloatingPlaceholder: false,
                                      labelText: 'Description',
                                      hintText: 'Describe the service',
                                      prefixIcon: Icon(Icons.note_add),
                                    ),
                                    validators: [
                                      FormBuilderValidators.required()
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: kMainHorizontalPadding,
                                      right: kMainHorizontalPadding,
                                      top: kMainHorizontalPadding),
                                  child: FormBuilderDropdown(
                                    attribute: 'terms',
                                    decoration: InputDecoration().copyWith(
                                      prefixIcon:
                                          Icon(Icons.supervisor_account),
                                    ),
                                    hint: Text('Terms'),
                                    validators: [
                                      FormBuilderValidators.required()
                                    ],
                                    items: [
                                      'Part Time',
                                      'Full time',
                                      'Unspecified'
                                    ]
                                        .map((service) => DropdownMenuItem(
                                              child: Text('$service'),
                                              value: service,
                                            ))
                                        .toList(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: kMainHorizontalPadding,
                                      right: kMainHorizontalPadding,
                                      top: kMainHorizontalPadding),
                                  child: FormBuilderDropdown(
                                    attribute: 'county',
                                    decoration: InputDecoration().copyWith(
                                      prefixIcon: Icon(Icons.category),
                                    ),
                                    hint: Text('Select your county'),
                                    validators: [
                                      FormBuilderValidators.required()
                                    ],
                                    items: counties
                                        .map(
                                          (county) => DropdownMenuItem(
                                            child: Text(county),
                                            value: county,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: kMainHorizontalPadding,
                                      right: kMainHorizontalPadding,
                                      top: kMainHorizontalPadding),
                                  child: FormBuilderTextField(
                                    attribute: 'town',
                                    decoration: InputDecoration().copyWith(
                                      hintText: 'Town',
                                      labelText: 'Town',
                                      prefixIcon: Icon(Icons.location_city),
                                    ),
                                    validators: [
                                      FormBuilderValidators.required()
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: kMainHorizontalPadding,
                                      right: kMainHorizontalPadding,
                                      top: kMainHorizontalPadding),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right:
                                                  kMainHorizontalPadding / 2),
                                          child: FormBuilderTextField(
                                            keyboardType: TextInputType.number,
                                            attribute: 'budgetMin',
                                            decoration:
                                                InputDecoration().copyWith(
                                              labelText: 'Budget From',
                                              prefixIcon: Icon(Icons.payment),
                                            ),
                                            validators: [
                                              FormBuilderValidators.required()
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: kMainHorizontalPadding / 2),
                                          child: FormBuilderTextField(
                                            keyboardType: TextInputType.number,
                                            attribute: 'budgetMax',
                                            decoration:
                                                InputDecoration().copyWith(
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
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: kMainHorizontalPadding,
                                      right: kMainHorizontalPadding,
                                      top: kMainHorizontalPadding),
                                  child: Text(
                                    "Service Image",
                                    style: kHeadingTextStyle.copyWith(
                                        color: Colors.grey.shade500),
                                  ),
                                ),
                                imageFile == null
                                    ? InkWell(
                                        onTap: () {
                                          showModalBottomSheet<void>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Container(
                                                  height: 100.0,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      FlatButton(
                                                        onPressed: () {
                                                          if (imageFile ==
                                                              null) {
                                                            _getImageGallery();
                                                          }
                                                        },
                                                        child: Text(
                                                            "Select from gallery"),
                                                      ),
                                                      FlatButton(
                                                        onPressed: () {
                                                          if (imageFile ==
                                                              null) {
                                                            _getImageCamera();
                                                          }
                                                        },
                                                        child: Text(
                                                            "Launch camera"),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              });
                                        },
                                        child: Icon(
                                          Icons.add_a_photo,
                                          size: 150.0,
                                          color: kPrimaryColor,
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            left: kMainHorizontalPadding,
                                            right: kMainHorizontalPadding,
                                            top: kMainHorizontalPadding),
                                        child: Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            Image.file(
                                              imageFile,
                                              width: 200.0,
                                              height: 200.0,
                                              fit: BoxFit.fitHeight,
                                            ),
                                            //Remove the selected image
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  imageFile = null;
                                                });
                                              },
                                              child: Icon(
                                                Icons.remove_circle,
                                                size: 28.0,
                                                color: kRedAlert,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: kMainHorizontalPadding,
                                      right: kMainHorizontalPadding,
                                      top: kMainHorizontalPadding),
                                  child: IconButtonWithText(
                                    text: "Order",
                                    icon: Icons.send,
                                    materialColor: kPrimaryColor,
                                    onTap: () async {
                                      if (imageFile == null) {
                                        displayDialog(context, 'Error',
                                            "You haven\'t selected an image");
                                      } else {
                                        if (_fbKey.currentState
                                            .saveAndValidate()) {
                                          final formData =
                                              _fbKey.currentState.value;

                                          setState(() {});
                                          final title = formData['title'];
                                          final description =
                                              formData['description'];
                                          final budgetMin = double.parse(
                                              formData['budgetMin']);
                                          final budgetMax = double.parse(
                                              formData['budgetMax']);
                                          final terms = formData['terms'];
                                          final county = formData['county'];
                                          final town = formData['town'];
                                          final categoryId =
                                              formData['categoryId'];
                                          final token = jwtSnapshot.data;

                                          await createService(
                                            county: county,
                                            town: town,
                                            token: token,
                                            title: title,
                                            description: description,
                                            budgetMin: budgetMin,
                                            budgetMax: budgetMax,
                                            categoryId: categoryId,
                                            filename: imageFile.path,
                                            ctxt: context,
                                            terms: terms,
                                          ); //Path of the image to upload
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        return ErrorScreen(
                          message: 'Invalid Token',
                          errorImage: kErrorImage,
                        );
                      }
                    }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
