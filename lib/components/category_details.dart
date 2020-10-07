import 'package:flutter/material.dart';
import 'package:servio/components/image_container.dart';
import 'package:servio/constants.dart';

class CategoryDetails extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String subCategories;
  final String serviceCount;
  final color;

  const CategoryDetails(
      {@required this.imageUrl,
      @required this.title,
      @required this.description,
      @required this.subCategories,
      @required this.serviceCount,
      @required this.color});

  @override
  _CategoryDetailsState createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  List<String> catSubCategories;
  @override
  void initState() {
    super.initState();

    setState(() {
      catSubCategories = getSubCategories(widget.subCategories);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.0,
      width: 300.0,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ImageContainer(
              isNetworkImage: true,
              borderRadius: 5.0,
              height: 220.0,
              imageUrl: widget.imageUrl,
              elevation: kElevationValue / 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Text(
                    '${widget.title}: ',
                    style: kHeadingTextStyle,
                  ),
                  Text(
                    "${widget.serviceCount} jobs available",
                    style: kHeadingSubTextStyle,
                  )
                ],
              ),
            ),
            Text(widget.description),
            Text(
              "Sub categories",
              style: kHeadingSubTextStyle.copyWith(
                color: Color(
                  hexColConvert(widget.color),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Wrap(
                spacing: kMainHorizontalPadding / 2,
                runSpacing: 6.0,
                children: catSubCategories
                    .map(
                      (text) => Material(
                        elevation: kElevationValue / 2,
                        color: Color(hexColConvert(widget.color)),
                        borderRadius: BorderRadius.circular(40.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: kMainHorizontalPadding),
                          child: Text(
                            text,
                            style: kTestTextStyleWhite.copyWith(fontSize: 16.0),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<String> getSubCategories(String items) {
  var array = items.split(' ');
  print(items);
  return array;
}
