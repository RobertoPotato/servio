import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:servio/screens/profile_screens/new_profile.dart';
import 'package:servio/screens/profile_screens/profile.dart';
import 'package:flutter/material.dart';

final storage = FlutterSecureStorage();

//write profile to phone
//storage.write(key: "profile", value: 'OK');

Future<String> get profileOrEmpty async {
  var profile = await storage.read(key: 'profile');
  if (profile == null) return "";
  return profile;
}

Widget profileOrNewProfile(String token, String profile){
  if(profile != ''){
    return ProfileScreen(token: token,);
  } else {
    return NewProfile();
  }
}