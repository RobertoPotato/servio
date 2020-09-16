import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:servio/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:servio/jwt_helpers.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:servio/screens/errors/error_screen.dart';

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
  bool autoValidate = true;
  bool readOnly = false;
  var initialStatusId = 1;
  File imageFile;
  var token;

  Map<String, String> get headers => {
        "x-auth-token": "Ze tokenzz",
      };

  Future<String> createService(
      String token,
      String title,
      String description,
      double budgetMin,
      double budgetMax,
      String terms,
      String imageUrl,
      int userId,
      int categoryId,
      int statusId,
      filename) async {
    final String url = "$kBaseUrl/v1/services";
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );
    //request.headers.addAll(headers);
    request.headers.addAll({"x-auth-token": "$token"});
    request.files.add(await http.MultipartFile.fromPath('imageUrl', filename));
    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['budgetMin'] = budgetMin.toString();
    request.fields['budgetMax'] = budgetMax.toString();
    request.fields['terms'] = terms;
    request.fields['userId'] = userId.toString();
    request.fields['categoryId'] = categoryId.toString();
    request.fields['statusId'] = statusId.toString();

    var res = await request.send();
    print("Status: ${res.statusCode}");
    if (res.statusCode == 200) {
      displayDialog(context, "Success", "Your request was saved successfully");
    }
    ;
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

  @override
  Widget build(BuildContext context) {
    print(imageFile);
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
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return CircularProgressIndicator();
                      if (snapshot.data != "") {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            FormBuilderTextField(
                              attribute: 'title',
                              decoration: InputDecoration().copyWith(
                                hintText: 'Title',
                                labelText: 'Title',
                                prefixIcon: Icon(Icons.work),
                              ),
                              validators: [FormBuilderValidators.required()],
                            ),
                            FormBuilderDropdown(
                              attribute: 'categoryId',
                              decoration: InputDecoration().copyWith(
                                prefixIcon: Icon(Icons.category),
                              ),
                              hint: Text('Select Service Category'),
                              validators: [FormBuilderValidators.required()],
                              items: [
                                Category(id: 1, title: 'Service one'),
                                Category(id: 2, title: 'Service two'),
                                Category(id: 3, title: 'Service three'),
                                Category(id: 4, title: 'Service four'),
                                Category(id: 5, title: 'Service five'),
                              ]
                                  .map((service) => DropdownMenuItem(
                                        child: Text(service.title),
                                        value: service.id,
                                      ))
                                  .toList(),
                            ),
                            FormBuilderTextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 7,
                              attribute: 'description',
                              decoration: InputDecoration().copyWith(
                                //hasFloatingPlaceholder: false,
                                labelText: 'Description',
                                hintText: 'Describe the service',
                                prefixIcon: Icon(Icons.note_add),
                              ),
                              validators: [FormBuilderValidators.required()],
                            ),
                            FormBuilderDropdown(
                              attribute: 'terms',
                              decoration: InputDecoration().copyWith(
                                prefixIcon: Icon(Icons.supervisor_account),
                              ),
                              hint: Text('Terms'),
                              validators: [FormBuilderValidators.required()],
                              items: ['Part Time', 'Full time', 'Unspecified']
                                  .map((service) => DropdownMenuItem(
                                        child: Text('$service'),
                                        value: service,
                                      ))
                                  .toList(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: kMainHorizontalPadding / 2),
                                    child: FormBuilderTextField(
                                      onFieldSubmitted: (str) {
                                        Navigator.pop(context);
                                      },
                                      keyboardType: TextInputType.number,
                                      attribute: 'budgetMin',
                                      decoration: InputDecoration().copyWith(
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
                                      decoration: InputDecoration().copyWith(
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
                            Text(
                              "Service Image",
                              style: kHeadingTextStyle.copyWith(
                                  color: Colors.grey.shade500),
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
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  FlatButton(
                                                    onPressed: () {
                                                      if (imageFile == null) {
                                                        _getImageGallery();
                                                      }
                                                    },
                                                    child: Text(
                                                        "Select from gallery"),
                                                  ),
                                                  FlatButton(
                                                    onPressed: () {
                                                      if (imageFile == null) {
                                                        _getImageCamera();
                                                      }
                                                    },
                                                    child:
                                                        Text("Launch camera"),
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
                                    ))
                                : Image.file(
                                    imageFile,
                                    width: 150.0,
                                    height: 150.0,
                                    fit: BoxFit.cover,
                                  ),
                            //Remove the selected image
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    imageFile = null;
                                  });
                                },
                                child: Icon(
                                  Icons.close,
                                  size: 24.0,
                                  color: kPrimaryColor,
                                )),
                            FlatButton(
                              onPressed: () async {
                                if (imageFile == null) {
                                  displayDialog(context, 'Error',
                                      "You haven\'t selected an image");
                                } else {
                                  if (_fbKey.currentState.saveAndValidate()) {
                                    final formData = _fbKey.currentState.value;
                                    final title = formData['title'];
                                    final description = formData['description'];
                                    final budgetMin =
                                        double.parse(formData['budgetMin']);
                                    final budgetMax =
                                        double.parse(formData['budgetMax']);
                                    final terms = formData['terms'];
                                    final imageUrl =
                                        kNetworkImage /*formData['imageUrl']*/;
                                    final userId = kUserId;
                                    final categoryId = 2;
                                    final statusId = 2;
                                    final token = snapshot.data;

                                    await createService(
                                        token,
                                        title,
                                        description,
                                        budgetMin.toDouble(),
                                        budgetMax.toDouble(),
                                        terms,
                                        imageUrl,
                                        userId,
                                        categoryId,
                                        statusId,
                                        imageFile
                                            .path); //Path of the image to upload
                                  }
                                }
                              },
                              child: Icon(
                                Icons.send,
                                size: 54.0,
                              ),
                            )
                          ],
                        );
                      } else {
                        return ErrorScreen(
                          message: 'Invalid Token',
                          errorImage: 'null',
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
