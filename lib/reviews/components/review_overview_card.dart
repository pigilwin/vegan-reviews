import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class ReviewOverviewCard extends StatelessWidget {

  const ReviewOverviewCard({
    this.review,
    this.onTap,
    this.shrink
  });

  static const double imageDimensions = 300;

  final Review review;
  final void Function(Review review) onTap;
  final bool shrink;

  @override
  Widget build(BuildContext context) {
    
    if (review == null) {
      return const SizedBox.shrink();
    }    
    return GestureDetector(
      onTap: () => onTap(review),
      child: Card(
        child: Container(
          child: Column(
            children: [
              _getImage(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(review.name, style: const TextStyle(fontSize: 20)),
                  WorthIt(review: review),
                ],
              ),
              StarRating(
                canBeEditted: false,
                onRatingChanged: null,
                stars: Review.amountOfStars,
                rating: review.stars,
                size: shrink ? 10.0 : 30.0,
              ),
              _getCreatedTime()
            ],
          ),
        ),
      )
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

  Widget _getCreatedTime() {
    
    double fontSize = 20;
    if (shrink) {
      fontSize = 10;
    }

    final DateFormat dateFormat = DateFormat.yMMMMEEEEd();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text("${dateFormat.format(review.created)}", style: TextStyle(fontSize: fontSize)),
    );
  }
}