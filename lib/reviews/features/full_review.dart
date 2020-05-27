import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class FullReview extends StatefulWidget {
  
  const FullReview(this.reviewId);

  final String reviewId;
  
  @override
  _FullReviewState createState() => _FullReviewState();
}

class _FullReviewState extends State<FullReview> {
  
  ReviewsBloc reviewsBloc;
  Review review;

  @override
  void initState() {
    super.initState();
    reviewsBloc = context.bloc<ReviewsBloc>();
    final ReviewsState state = reviewsBloc.state;
    if (state is LoadedReviews) {
      review = state.getReviewById(widget.reviewId);
    }
  }

  @override
  Widget build(BuildContext context) {
    
  }
}