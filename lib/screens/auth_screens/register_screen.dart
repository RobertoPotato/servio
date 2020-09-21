import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:servio/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  static String id = 'register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool passwordsMatch;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  bool _checkPasswordMatch(pasMain, pasCompare) {
    if (pasMain != pasCompare) {
      setState(() {
        passwordsMatch = false;
      });
      return false;
    } else {
      setState(() {
        passwordsMatch = true;
      });
      return true;
    }
  }

  Icon _iconToShow() {
    if (passwordsMatch == null) {
      return Icon(
        Icons.check_box_outline_blank,
        color: kPrimaryColor,
      );
    } else if (passwordsMatch == true) {
      return Icon(
        Icons.check,
        color: kMyBidsColor,
      );
    } else {
      return Icon(
        Icons.warning,
        color: kMySettingsColor,
      );
    }
  }

  Future registerUser(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    print("$firstName $lastName is registered");
    final String url = "$kBaseUrl/v1/auth/register";
    final response = await http.post(Uri.encodeFull(url),
        body: json.encode({
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "password": password
        }),
        headers: {
          "accept": "application/json",
          "content-type": "application/json"
        });
    if(response.statusCode == 200) {
      print(response.body);
    } else {
      print("Request failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FormBuilder(
                key: _fbKey,
                child: Column(
                  children: [
                    FormBuilderTextField(
                      attribute: 'firstName',
                      decoration: InputDecoration().copyWith(
                        hintText: 'First Name',
                        labelText: 'First Name',
                        //prefixIcon: Icon(Icons.work),
                      ),
                      validators: [FormBuilderValidators.required()],
                    ),
                    FormBuilderTextField(
                      attribute: 'lastName',
                      decoration: InputDecoration().copyWith(
                        hintText: 'Last Name',
                        labelText: 'Last Name',
                        //prefixIcon: Icon(Icons.work),
                      ),
                      validators: [FormBuilderValidators.required()],
                    ),
                    FormBuilderTextField(
                      attribute: 'email',
                      decoration: InputDecoration().copyWith(
                        hintText: 'Email',
                        labelText: 'Email',
                        //prefixIcon: Icon(Icons.work),
                      ),
                      validators: [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email()
                      ],
                    ),
                    FormBuilderTextField(
                      attribute: 'password',
                      decoration: InputDecoration().copyWith(
                        hintText: 'Password',
                        labelText: 'Password',
                        prefixIcon: _iconToShow(),
                      ),
                      validators: [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(8)
                      ],
                    ),
                    FormBuilderTextField(
                      attribute: 'passwordRepeat',
                      decoration: InputDecoration().copyWith(
                        hintText: 'Repeat Password',
                        labelText: 'Repeat Password',
                        prefixIcon: _iconToShow(),
                      ),
                      validators: [FormBuilderValidators.required()],
                    ),
                    Text("Password status")
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {
                  if (_fbKey.currentState.saveAndValidate()) {
                    final formData = _fbKey.currentState.value;
                    final firstName = formData['firstName'].toString().trim();
                    final lastName = formData['lastName'].toString().trim();
                    final email = formData['email'].toString().trim();
                    final password = formData['password'].toString().trim();
                    final passwordRepeat =
                        formData['passwordRepeat'].toString().trim();

                    if (_checkPasswordMatch(password, passwordRepeat)) {
                      print('Everything is safe, you can post');
                      registerUser(firstName, lastName, email, password);
                      //TODO On complete, go to login screen and log in
                    } else {
                      print("Theres a problem registering user");
                    }
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
