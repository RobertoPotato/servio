import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servio/components/category_card.dart';
import 'package:servio/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:servio/models/Category.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    final response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    final jsonResponse = json.decode(response.body);

    setState(() {
      data = json.decode(response.body);
    });

    if (response.statusCode == 200) {
      return Category.fromJson(jsonResponse[0]);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Categories'),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kMainHorizontalPadding),
              child: GestureDetector(
                onTap: () {
                  const kMessage = "Long press a category for more information";
                  Fluttertoast.showToast(
                      msg: kMessage,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.SNACKBAR,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.grey[700],
                      textColor: Colors.white,
                      fontSize: 16.0);
                },
                child: Icon(
                  Icons.info,
                  color: kAccentColor,
                ),
              ),
            )
          ],
        ),
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
