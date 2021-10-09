import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan_reviews/authentication/authentication.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class SavedFeed extends StatefulWidget {
  const SavedFeed({required Key key}) : super(key: key);


  @override
  _SavedFeedState createState() => _SavedFeedState();
}

class _SavedFeedState extends State<SavedFeed> with AutomaticKeepAliveClientMixin<SavedFeed> {

  late AuthenticationBloc authenticationBloc;
  ReviewsBloc? reviewsBloc;

  @override
  void initState() {
    super.initState();
    authenticationBloc = context.read<AuthenticationBloc>();
    reviewsBloc = context.read<ReviewsBloc>();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<ReviewsBloc, ReviewsState>(
      bloc: reviewsBloc,
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
                ///
                /// The item is currently saved, removing
                ///
                if (state.savedReviews.contains(review.id)) {
                  reviewsBloc!.add(UnSaveReviewEvent(review));
                } else {
                  reviewsBloc!.add(SaveReviewEvent(review));
                }
              }
            );
          }
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}