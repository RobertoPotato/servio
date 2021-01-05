import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:servio/components/image_container.dart';
import 'package:servio/models/ErrorResponse.dart';
import '../../jwt_helpers.dart';
import '../parent_screen.dart';

class EditProfile extends StatefulWidget {
  EditProfile(
      {@required this.token,
      @required this.bio,
      @required this.phoneNumber,
      @required this.picture});
  final String token;
  final String bio;
  final String phoneNumber;
  final picture;
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File imageFile;
  double screenHeight;

  Future<String> editProfileWithPic(
      {@required String token,
      @required String bio,
      @required String phoneNumber,
      @required filename,
      @required ctxt}) async {
    final String url = "$kBaseUrl/v1/profiles/update";

    final request = http.MultipartRequest(
      'PUT',
      Uri.parse(url),
    );

    request.headers.addAll({"x-auth-token": token});
    request.files.add(await http.MultipartFile.fromPath('picture', filename));

    request.fields['bio'] = bio;
    request.fields['phoneNumber'] = phoneNumber;

    var response = await request.send();

    if (response.statusCode == 200) {
      Navigator.pushNamedAndRemoveUntil(
          context, MainParentScreen.id, (route) => false);
    } else if (response.statusCode == 400) {
      var error = "Profile not found. Please try again";
      displayResponseCard(ctxt, "Oops!", error, kErrorImage);
      return error;
    } else {
      displayResponseCard(
          ctxt, kUniversalErrorTitle, kSomethingWrongException, kErrorImage);
    }

    return "";
  }

  Future<String> editProfileWithoutPic(
      {@required String token,
      @required String bio,
      @required String phoneNumber,
      @required ctxt}) async {
    final String url = "$kBaseUrl/v1/profiles/update";

    final response = await http.put(Uri.encodeFull(url),
        body: json.encode({"bio": bio, "phoneNumber": phoneNumber}),
        headers: {
          "accept": "application/json",
          "content-type": "application/json",
          "x-auth-token": "$token"
        });

    if (response.statusCode == 200) {
      Navigator.pushNamedAndRemoveUntil(
          context, MainParentScreen.id, (route) => false);
    } else if (response.statusCode == 400) {
      var error = errorFromJson(response.body);
      print(error.error);
      displayResponseCard(ctxt, "Oops!", error.error, kErrorImage);
      return error.error;
    } else {
      displayResponseCard(ctxt, "Oops!", kSomethingWrongException, kErrorImage);
      return kSomethingWrongException;
    }

    return "";
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

  //TODO Change this to adapt to IOS comfortably
  getScreenHeight() {
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    screenHeight = height - padding.top - padding.bottom;
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
            child: Text('Stay'),
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getScreenHeight();
    double scHeight = screenHeight / 2;
    print(widget.token);
    print("$kImageBaseUrl${widget.picture}");
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: FormBuilder(
              key: _fbKey,
              child: Column(
                children: [
                  Container(
                    height: scHeight,
                    child: imageFile == null
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
                                            child: Text("Select from gallery"),
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
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                ImageContainer(
                                    borderRadius: 5.0,
                                    bottomRightRad: 20.0,
                                    bottomLeftRad: 20.0,
                                    elevation: 2.0,
                                    imageUrl: "$kImageBaseUrl${widget.picture}",
                                    isNetworkImage: true,
                                    height: scHeight),
                                Container(
                                  color: Colors.black.withOpacity(0.7),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(
                                      Icons.edit,
                                      size: 60,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Stack(alignment: Alignment.topRight, children: [
                            Image.file(
                              imageFile,
                              width: double.infinity,
                              height: scHeight,
                              fit: BoxFit.fitHeight,
                            ),
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
                          ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: kMainHorizontalPadding,
                        right: kMainHorizontalPadding,
                        top: kMainHorizontalPadding),
                    child: FormBuilderTextField(
                      initialValue: widget.bio,
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      attribute: 'bio',
                      decoration: InputDecoration().copyWith(
                        //hasFloatingPlaceholder: false,
                        labelText: 'Bio',
                        hintText: 'Say something about yourself',
                        prefixIcon: Icon(Icons.chat_bubble),
                      ),
                      validators: [FormBuilderValidators.required()],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: kMainHorizontalPadding,
                        right: kMainHorizontalPadding,
                        top: kMainHorizontalPadding),
                    child: FormBuilderTextField(
                      initialValue: widget.phoneNumber,
                      attribute: 'phoneNumber',
                      decoration: InputDecoration().copyWith(
                        hintText: 'Phone Number',
                        labelText: 'Phone',
                        prefixIcon: Icon(Icons.phone),
                      ),
                      validators: [FormBuilderValidators.required()],
                    ),
                  ),
                  FlatButton(
                    color: kPrimaryColor,
                    textColor: Colors.white,
                    //TODO Navigates user out to the home page with NO BACK option
                    onPressed: () async {
                      print("Update Profile");
                      if (_fbKey.currentState.saveAndValidate()) {
                        final formData = _fbKey.currentState.value;
                        final bio = formData['bio'];
                        final phoneNumber = formData['phoneNumber'];

                        imageFile == null
                            ? editProfileWithoutPic(
                                token: widget.token,
                                bio: bio,
                                phoneNumber: phoneNumber,
                                ctxt: context)
                            : await editProfileWithPic(
                                token: widget.token,
                                bio: bio,
                                phoneNumber: phoneNumber,
                                filename: imageFile.path,
                                ctxt: context); //Path of the image to upload
                      }
                    },
                    child: Text("Update"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
