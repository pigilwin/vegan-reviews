import 'package:flutter/material.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class LatestReviewOverviewCard extends StatelessWidget {

  const LatestReviewOverviewCard({
    this.review,
    this.onTap
  });

  final Review review;
  final void Function(Review review) onTap;

  @override
  Widget build(BuildContext context) {
    
    if (review == null) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        const Text("Latest Review", style: TextStyle(fontSize: 20)),
        ReviewOverviewCard(
          review: review,
          onTap: onTap,
        ),
      ],
    );
  }
}