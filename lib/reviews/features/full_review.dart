import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan_reviews/authentication/authentication.dart';
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
    return BlocBuilder<ReviewsBloc, ReviewsState>(
      builder: (BuildContext context, ReviewsState state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(review.name, style: const TextStyle(color: Colors.white)),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ReviewOverviewCard(
                    latestReview: false,
                    onTap: null,
                    review: review,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child:Material(
                    child: SafeArea(
                      child: Text(review.description,
                        overflow: TextOverflow.ellipsis,
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: _getEditReviewButton(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }

  Widget _getEditReviewButton() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (BuildContext context, AuthenticationState state) {
        if (state is Authenticated){
          return FloatingActionButton(
            child: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).pushNamed('/new-review');
            },
          );
        }
        return Container();
      },
    );
  }
}