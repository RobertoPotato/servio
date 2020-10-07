import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/screens/category-services.dart';
import 'package:servio/components/image_container.dart';
import 'package:servio/jwt_helpers.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    @required this.data,
    @required this.index,
  }) : super(key: key);

  final List data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: (){
        displayResponseCard(context, data[index]['title'], 'Long press', kSuccessImage);
      },
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
        child: Column(
          children: <Widget>[
            ImageContainer(
              height: 150.0,
              imageUrl: data[index]['imageUrl'],
              borderRadius: 5.0,
              elevation: 0.0,
              isNetworkImage: true,
            ),
            //Text(data[index]['id'].toString()),
            Text(
              data[index]['title'],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(hexColConvert(data[index]['themeColor'])),
              ),
            ),
            Text(
              "${data[index]['serviceCount']} available jobs",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(hexColConvert(data[index]['themeColor'])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
