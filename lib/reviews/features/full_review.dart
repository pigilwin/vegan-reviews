import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: ReviewOverviewCard(
                  onTap: null,
                  review: review,
                ),
              ),
              Card(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    SafeArea(
                      child: Text(review.description,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    _getSupplier(),
                    _getType()
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                width: double.infinity,
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Align(
                    alignment: Alignment.center,
                    child: StarRating(
                      canBeEditted: false,
                      onRatingChanged: null,
                      stars: 5,
                      rating: review.stars,
                      size: 60.0,
                    ),
                  ),
                ),
              ),
              _getLimitedTime(),
              _getCreatedTime()
            ],
          ),
        ),
      ),
      floatingActionButton: _getEditReviewButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
  
  Widget _getLimitedTime() {
    if (review.limited) {
      return const Card(
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: SafeArea(
            child: Text("This was a limited time item so may not be avalible anylonger", 
              style: TextStyle(fontSize: 20),
              overflow: TextOverflow.clip,
            ),
          )
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _getType() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text("This food is ${review.type}", style: const TextStyle(fontSize: 20)),
    );
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
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Text("This was reviewed on ${dateFormat.format(review.created)}", style: const TextStyle(fontSize: 18)),
      ),
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