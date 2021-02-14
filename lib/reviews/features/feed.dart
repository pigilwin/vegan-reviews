import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class Feed extends StatefulWidget {

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewsBloc, ReviewsState>(
      builder: (context, ReviewsState state) {
        return ListView.builder(
          itemCount: state.allPossibleReviews.length,
          itemBuilder: (context, i) {
            final review = state.allPossibleReviews[i];
            return ReviewCard(
              review: review
            );
          }
        );
      },
    );
  }
}