import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:servio/screens/category-services.dart';

class Category {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final String themeColor;

  Category(
      {this.id, this.title, this.description, this.imageUrl, this.themeColor});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      themeColor: json['themeColor'],
    );
  }
}

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
        ),
        body: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => CategoryServices(
                      categoryId: data[index]['id'],
                      categoryTitle: data[index]['title'],
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kMainHorizontalPadding,
                    vertical: kMainHorizontalPadding / 4),
                child: Card(
                  //color: Color(hexColConvert(data[index]['themeColor'])),
                  elevation: kElevationValue / 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kMainHorizontalPadding,
                        vertical: kMainHorizontalPadding / 2),
                    child: Column(
                      children: <Widget>[
                        Text(data[index]['id'].toString()),
                        Text(
                          data[index]['title'],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color:
                                Color(hexColConvert(data[index]['themeColor'])),
                          ),
                        ),
                        Text(data[index]['description']),
                        Text(data[index]['imageUrl']),
                        Text(data[index]['themeColor']),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
