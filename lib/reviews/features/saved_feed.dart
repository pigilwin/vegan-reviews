import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan_reviews/authentication/authentication.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class SavedFeed extends StatefulWidget {

  @override
  _SavedFeedState createState() => _SavedFeedState();
}

class _SavedFeedState extends State<SavedFeed> {

  AuthenticationBloc authenticationBloc;
  ReviewsBloc reviewsBloc;

  @override
  void initState() {
    super.initState();
    authenticationBloc = context.read<AuthenticationBloc>();
    reviewsBloc = context.read<ReviewsBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewsBloc, ReviewsState>(
      cubit: reviewsBloc,
      builder: (context, ReviewsState state) {
        return ListView.builder(
          itemCount: state.savedReviews.length,
          itemBuilder: (context, i) {
            final review = state.getReviewById(state.savedReviews[i]);
            return ReviewCard(
              review: review,
              isSaved: state.savedReviews.contains(review.id),
              onTap: () {
                if (authenticationBloc.state is Authenticated) {
                  Navigator.of(context).pushNamed('/review/edit', arguments: review.id);
                }
              },
              toggleSave: () {
                if (authenticationBloc.state is Authenticated) {

                  ///
                  /// The item is currently saved, removing
                  ///
                  if (state.savedReviews.contains(review.id)) {
                    reviewsBloc.add(UnSaveReviewEvent(review));
                  } else {
                    reviewsBloc.add(SaveReviewEvent(review));
                  }
                }
              }
            );
          }
        );
      },
    );
  }
}