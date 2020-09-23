import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
//Contains various functions including the http request maker
import 'register_helpers.dart';



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
                        prefixIcon: iconToShow(passwordsMatch),
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
                        prefixIcon: iconToShow(passwordsMatch),
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
