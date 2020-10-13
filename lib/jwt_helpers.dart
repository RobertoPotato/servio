import 'dart:convert' show json, base64, ascii;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'components/response_card.dart';
import 'components/create_review.dart';

final storage = FlutterSecureStorage();

Future<String> get jwtOrEmpty async {
  var jwt = await storage.read(key: 'x-auth-token');
  if (jwt == null) return "";
  return verifyToken(jwt) ? jwt : "";
}

bool verifyToken(String token) {
  var jwt = token.split(".");
  if (jwt.length != 3) {
    return false;
  } else {
    var payload = json.decode(
      ascii.decode(
        base64.decode(
          base64.normalize(jwt[1]),
        ),
      ),
    );
    if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000).isAfter(
      DateTime.now(),
    )) {
      return true;
    } else {
      return false;
    }
  }
}

void displayDialog(ctxt, title, text) => showDialog(
      context: ctxt,
      builder: (ctxt) => AlertDialog(
        title: Text(title),
        content: Text(text),
      ),
    );

void displayResponseCard(ctxt, title, text, imageUrl) => showDialog(
      context: ctxt,
      builder: (ctxt) => AlertDialog(
        content: ResponseCard(
          title: title,
          text: text,
          imageUrl: imageUrl,
        ),
      ),
    );

logOutUser(ctxt, screen) async {
  print("Logging out");
  await storage.delete(key: "x-auth-token");
  Navigator.pushNamedAndRemoveUntil(ctxt, screen, (route) => false);
}
