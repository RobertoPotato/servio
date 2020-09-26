import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:servio/constants.dart';
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
    var valueVert = 20.0;
    var valueHor = 10.0;
    spaceVert(double value) {
      return SizedBox(
        height: value,
      );
    }
    spaceHor(double value){
      return SizedBox(
        width: value,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: kMainHorizontalPadding / 2,
                horizontal: kMainHorizontalPadding),
            child: Column(
              children: <Widget>[
                Image.asset(
                  "images/icon.png",
                  height: 220.0,
                  width: 220.0,
                  fit: BoxFit.cover,
                ),
                FormBuilder(
                  key: _fbKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: FormBuilderTextField(
                              attribute: 'firstName',
                              decoration: InputDecoration().copyWith(
                                hintText: 'First Name',
                                labelText: 'First Name',
                                //prefixIcon: Icon(Icons.work),
                              ),
                              validators: [FormBuilderValidators.required()],
                            ),
                          ),
                          spaceHor(valueHor),
                          Expanded(
                            child: FormBuilderTextField(
                              attribute: 'lastName',
                              decoration: InputDecoration().copyWith(
                                hintText: 'Last Name',
                                labelText: 'Last Name',
                                //prefixIcon: Icon(Icons.work),
                              ),
                              validators: [FormBuilderValidators.required()],
                            ),
                          ),
                        ],
                      ),
                      spaceVert(valueVert),
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
                      spaceVert(valueVert),
                      Row(
                        children: [
                          Expanded(
                            child: FormBuilderTextField(
                              attribute: 'password',
                              obscureText: true,
                              obscuringCharacter: "\$",
                              decoration: InputDecoration().copyWith(
                                hintText: 'Password',
                                labelText: 'Password',
                              ),
                              validators: [
                                FormBuilderValidators.required(),
                                FormBuilderValidators.minLength(8)
                              ],
                            ),
                          ),
                          spaceHor(valueHor),
                          Expanded(
                            child: FormBuilderTextField(
                              attribute: 'passwordRepeat',
                              obscureText: true,
                              obscuringCharacter: "\$",
                              decoration: InputDecoration().copyWith(
                                hintText: 'Repeat Password',
                                labelText: 'Repeat Password',
                              ),
                              validators: [FormBuilderValidators.required()],
                            ),
                          ),
                        ],
                      ),
                      spaceVert(valueVert),
                      Center(
                        child: Row(
                          children: [
                            iconToShow(passwordsMatch),
                            Text("Password status"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                FlatButton(
                  color: kPrimaryColor,
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
                  child: Text(
                    'Submit',
                    style: kTestTextStyleWhite,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
