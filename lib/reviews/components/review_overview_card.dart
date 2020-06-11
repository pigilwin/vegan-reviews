import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class ReviewOverviewCard extends StatelessWidget {

  const ReviewOverviewCard({
    this.review,
    this.onTap
  });

  static const double imageDimensions = 300;

  final Review review;
  final void Function(Review review) onTap;

  @override
  Widget build(BuildContext context) {
    
    if (review == null) {
      return const SizedBox.shrink();
    }    
    return GestureDetector(
      onTap: () {
        onTap(review);
      },
      child: Card(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)
            )
          ),
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
                size: 30.0,
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
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(5)
      ),
      child: Image.network(review.imageUrl),
    );
  }

  Widget _getCreatedTime() {
    final DateFormat dateFormat = DateFormat.yMMMMEEEEd();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text("${dateFormat.format(review.created)}", style: const TextStyle(fontSize: 18)),
    );
  }
}