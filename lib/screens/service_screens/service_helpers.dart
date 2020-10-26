import 'package:servio/constants.dart';
import 'package:http/http.dart' as http;
import 'package:servio/jwt_helpers.dart';
import 'package:flutter/material.dart';

/*
      Uploads the service
*/
Future<String> createService(
    {@required String county,
    @required String town,
    @required String token,
    @required String title,
    @required String description,
    @required double budgetMin,
    @required double budgetMax,
    @required String terms,
    @required int categoryId,
    @required filename,
    @required ctxt}) async {
  final String url = "$kBaseUrl/v1/services";
  final request = http.MultipartRequest(
    'POST',
    Uri.parse(url),
  );
  request.headers.addAll({"x-auth-token": "$token"});
  request.files.add(await http.MultipartFile.fromPath('imageUrl', filename));
  request.fields['county'] = county;
  request.fields['town'] = town;
  request.fields['title'] = title;
  request.fields['description'] = description;
  request.fields['budgetMin'] = budgetMin.toString();
  request.fields['budgetMax'] = budgetMax.toString();
  request.fields['terms'] = terms;
  request.fields['categoryId'] = categoryId.toString();

  var res = await request.send();
  print("Status: ${res.statusCode}");
  if (res.statusCode == 200) {
    displayDialog(ctxt, "Success", "Your request was saved successfully");
  }
  return "";
}
