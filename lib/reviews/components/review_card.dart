import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class ReviewCard extends StatelessWidget {

  const ReviewCard({
    this.review
  });

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(6.5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _getImage(),
            _getText(),
            _getStars(),
            _getCreatedTime()
          ],
        ),
      ),
    );
  }

  Widget _getImage() {
    if (review.imageUrl.isEmpty) {
      return const SizedBox.shrink();
    }
    return Image.network(review.imageUrl,
      loadingBuilder: (BuildContext context, Widget widget, ImageChunkEvent event) {
        if (event == null) {
          return widget;
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    );
  }

  Widget _getText() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Text(
            review.name + ': ',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          )
        ),
        Expanded(
          child: Text(review.description)
        ),
      ],
    );
  }

  Widget _getStars() {
    return Row(
      children: <Widget>[
        StarRating(
          canBeEditted: false,
          stars: Review.amountOfStars,
          rating: review.stars,
          size: 20.0,
          onRatingChanged: null,
        ),
      ],
    );
  }

  Widget _getCreatedTime() {
    final dateFormat = DateFormat.yMMMMEEEEd();
    return Row(
      children: <Widget>[
        Text('${dateFormat.format(review.created)}'),
      ],
    );
  }
}