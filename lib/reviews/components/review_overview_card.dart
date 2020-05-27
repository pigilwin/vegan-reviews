import 'package:flutter/material.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class ReviewOverviewCard extends StatelessWidget {

  const ReviewOverviewCard({
    this.review,
    this.onTap,
    this.latestReview
  });

  final Review review;
  final void Function(Review review) onTap;
  final bool latestReview;

  @override
  Widget build(BuildContext context) {
    
    if (review == null) {
      return const SizedBox.shrink();
    }

    String reviewText = review.name;
    if (latestReview) {
      reviewText = "Latest Review: ${review.name}";
    }
    
    return GestureDetector(
      onTap: () {
        onTap(review);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)
              ),
              child: Image.file(review.image),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      reviewText,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}