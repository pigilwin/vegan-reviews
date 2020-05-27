import 'package:flutter/material.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class ReviewOverviewCard extends StatelessWidget {

  const ReviewOverviewCard({
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
    return GestureDetector(
      onTap: () {
        onTap(review);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Image.file(review.image, width: 300, height: 300, cacheHeight: 300, cacheWidth: 300, fit: BoxFit.fill),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Material(
              elevation: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      review.name,
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                  WorthIt(worthIt: review.worthIt)
                ],
              ),
            ),
          )
        ]
      ),
    );
  }
}