import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
                    onTap: null,
                    review: review,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child:Material(
                    child: SafeArea(
                      child: Text(review.description,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                _getSupplier(),
                const Divider(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: StarRating(
                    canBeEditted: false,
                    onRatingChanged: null,
                    stars: 10,
                    rating: review.stars,
                    size: 30.0,
                  ),
                ),
                const Divider(
                  height: 16,
                ),
                _getLimitedTime(),
                _getCreatedTime()
              ],
            ),
          ),
          floatingActionButton: _getEditReviewButton(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }
  
  Widget _getLimitedTime() {
    if (review.limited) {
      return const Padding(
        padding: EdgeInsets.all(10),
        child: SafeArea(
          child: Text("This was a limited time item so may not be avalible anylonger", 
            style: TextStyle(fontSize: 20),
            overflow: TextOverflow.clip,
          ),
        )
      );
    }
    return const SizedBox.shrink();
  }

  Widget _getSupplier() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Supplier: ${review.supplier}", style: const TextStyle(fontSize: 20)),
          Text("Price: ${review.price}", style: const TextStyle(fontSize: 20)),
        ],
      )
    );
  }
 
  Widget _getCreatedTime() {
    final DateFormat dateFormat = DateFormat.yMMMMEEEEd();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text("This was reviewed on ${dateFormat.format(review.created)}", style: const TextStyle(fontSize: 18)),
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