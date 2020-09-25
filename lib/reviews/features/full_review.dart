import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vegan_reviews/authentication/authentication.dart';
import 'package:vegan_reviews/reviews/reviews.dart';
import 'package:vegan_reviews/shared/shared.dart';

class FullReview extends StatefulWidget {
  
  const FullReview(this.reviewId);

  final String reviewId;
  
  @override
  _FullReviewState createState() => _FullReviewState();
}

class _FullReviewState extends State<FullReview> {
  
  ReviewsBloc reviewsBloc;
  Review review;
  bool editMode = false;

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
        
        if (state is LoadingReviews) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        
        if (editMode) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    editMode = false;
                  });
                },
              ),
              title: Text("Editting ${review.name}"),
              centerTitle: true,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: ReviewEditor(
                  review: review,
                  reviewFinished: (Review review) {
                    reviewsBloc.add(EditReviewEvent(review));
                    setState(() {
                      editMode = false;
                      this.review = review;
                    });
                  },
                  reviewDeleted: (Review review) {
                    reviewsBloc.add(DeleteReviewEvent(review));
                    Navigator.of(context).pop();
                  },
                ),
              ),
            )
          );
        }
        return _getFullReviewPage();
      },
    );
  }

  Widget _getFullReviewPage() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(review.name, style: const TextStyle(color: Colors.white)),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: VeganGradient.gradient(0.2)
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: ReviewOverviewCard(
                onTap: null,
                review: review,
                shrink: false
              ),
            ),
            Expanded(
              child: Card(
                margin: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: SingleChildScrollView(
                          child: SafeArea(
                            child: Text(review.description,
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      const Divider(height: 20),
                      _getSupplier(),
                      _getPrice(),
                      _getLimitedTime(),
                    ],
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
  }
  
  Widget _getLimitedTime() {
    if (review.limited) {
      return const Padding(
        padding: EdgeInsets.all(10),
        child: SafeArea(
          child: Text("This was a limited time item so may not be avalible anylonger", 
            style: TextStyle(fontSize: 20, color: Colors.red),
            overflow: TextOverflow.clip,
          )
        )
      );
    }
    return const SizedBox.shrink();
  }

  Widget _getSupplier() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text("Brand: ${review.supplier}", style: const TextStyle(fontSize: 20)),
    );
  }

  Widget _getPrice() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text("Price: £${review.price.toStringAsFixed(2)}", style: const TextStyle(fontSize: 20)),
    );
  }

  Widget _getEditReviewButton() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (BuildContext context, AuthenticationState state) {
        if (state is Authenticated){
          return FloatingActionButton(
            child: const Icon(Icons.edit),
            onPressed: () {
              setState(() {
                editMode = true;
              });
            },
          );
        }
        return Container();
      },
    );
  }
}