import 'package:flutter/material.dart';
import 'package:servio/components/review_card.dart';

class ListOfReviews extends StatefulWidget {
  final List reviews;

  ListOfReviews({@required this.reviews});

  @override
  _ListOfReviewsState createState() => _ListOfReviewsState();
}

class _ListOfReviewsState extends State<ListOfReviews> {
  List allReviews;

  @override
  void setState(fn) {
    super.setState(fn);
    allReviews = widget.reviews;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.reviews.length);
    return Container(
      height: 160.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.reviews == null ? 0 : widget.reviews.length,
        itemBuilder: (BuildContext context, int index) {
          return ReviewCard(
            reviewerName:
                "${widget.reviews[index]['User']['firstName']} ${widget.reviews[index]['User']['lastName']}",
            review: widget.reviews[index]["content"],
            rating: widget.reviews[index]["stars"].toString(),
          );
        },
      ),
    );
  }
}
