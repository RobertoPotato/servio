import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servio/components/category_card.dart';
import 'package:servio/constants.dart';
import 'package:http/http.dart' as http;
import 'package:servio/jwt_helpers.dart';
import 'dart:convert';
import 'package:servio/models/Category.dart';

class Categories extends StatefulWidget {
  final String token;

  const Categories({@required this.token});
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Future<Category> futureCategory;

  List data;
  @override
  void initState() {
    super.initState();
    futureCategory = fetchCategory();
  }

  Future<Category> fetchCategory() async {
    var url = '$kBaseUrl/v1/categories';
    try {
      final response = await http.get(Uri.encodeFull(url), headers: {
        "Accept": "application/json"
      }).timeout(Duration(seconds: 10));

      final jsonResponse = json.decode(response.body);

      setState(() {
        data = json.decode(response.body);
      });

      if (response.statusCode == 200) {
        return Category.fromJson(jsonResponse[0]);
      } else {
        throw Exception(kCategoriesNotFound);
      }
    } on TimeoutException catch (e) {
      print(e.message);
      displayResponseCard(context, "Error", kRequestTimedOut, kErrorImage);
    } on SocketException catch (e) {
      print(e.message);
      displayResponseCard(context, "Error", kNoConnection, kErrorImage);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        /**/
        body: data == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : data.length != 0
                ? GridView.builder(
                    itemCount: data == null ? 0 : data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index) {
                      return CategoryCard(
                        data: data,
                        index: index,
                      );
                    })
                : Center(
                    child: Text("A problem occurred while fetching categories"),
                  ),
      ),
    );
  }
}
