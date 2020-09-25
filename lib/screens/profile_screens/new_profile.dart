import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:servio/jwt_helpers.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:servio/constants.dart';
import 'package:servio/screens/errors/error_screen.dart';
import 'package:servio/screens/parent_screen.dart';

class NewProfile extends StatefulWidget {
  static String id = "new profile";
  @override
  _NewProfileState createState() => _NewProfileState();
}

class Role {
  final int id;
  final String title;
  Role({@required this.id, @required this.title});
}

class _NewProfileState extends State<NewProfile> {
  File imageFile;

  Future<String> createProfile(String token, filename, String bio,
      String phoneNumber, int roleId) async {
    print("$phoneNumber $roleId");
    final String url = "$kBaseUrl/v1/profiles";
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    request.headers.addAll({"x-auth-token": token});
    request.files.add(await http.MultipartFile.fromPath('picture', filename));
    request.fields['bio'] = bio;
    request.fields['phoneNumber'] = phoneNumber;
    request.fields['roleId'] = roleId.toString();

    var res = await request.send();
    if (res.statusCode == 200) {
      await storage.write(key: "profile", value: 'OK').then(
            (value) => Navigator.pushNamed(context, MainParentScreen.id),
          );
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Create Profile"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: jwtOrEmpty,
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return CircularProgressIndicator();
                else if (snapshot.hasError) {
                  return ErrorScreen(
                    message: "Invalid token",
                    errorImage: kErrorImage,
                  );
                } else {
                  return FormBuilder(
                    key: _fbKey,
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          attribute: 'phoneNumber',
                          decoration: InputDecoration().copyWith(
                            hintText: 'Phone Number',
                            labelText: 'Phone',
                            prefixIcon: Icon(Icons.work),
                          ),
                          validators: [FormBuilderValidators.required()],
                        ),
                        FormBuilderTextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 4,
                          attribute: 'bio',
                          decoration: InputDecoration().copyWith(
                            //hasFloatingPlaceholder: false,
                            labelText: 'Bio',
                            hintText: 'Say something about yourself',
                            prefixIcon: Icon(Icons.note_add),
                          ),
                          validators: [FormBuilderValidators.required()],
                        ),
                        FormBuilderDropdown(
                          attribute: 'roleId',
                          decoration: InputDecoration().copyWith(
                            prefixIcon: Icon(Icons.category),
                          ),
                          hint: Text('Role'),
                          validators: [FormBuilderValidators.required()],
                          items: [Role(id: 1, title: "Individual")]
                              .map((role) => DropdownMenuItem(
                                    child: Text(role.title),
                                    value: role.id,
                                  ))
                              .toList(),
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
                                                child:
                                                    Text("Select from gallery"),
                                              ),
                                              FlatButton(
                                                onPressed: () {
                                                  if (imageFile == null) {
                                                    _getImageCamera();
                                                  }
                                                },
                                                child: Text("Launch camera"),
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
                          ),
                        ),
                        FlatButton(
                          onPressed: () async {
                            if (imageFile == null) {
                              displayDialog(context, 'Error',
                                  "You haven\'t selected an image");
                            } else {
                              if (_fbKey.currentState.saveAndValidate()) {
                                final formData = _fbKey.currentState.value;
                                final bio = formData['bio'];
                                final phoneNumber = formData['phoneNumber'];
                                final roleId = formData['roleId'];
                                final token = snapshot.data;

                                await createProfile(
                                    token,
                                    imageFile.path,
                                    bio,
                                    phoneNumber,
                                    roleId); //Path of the image to upload
                              }
                            }
                          },
                          child: Icon(
                            Icons.send,
                            size: 54.0,
                          ),
                        )
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
