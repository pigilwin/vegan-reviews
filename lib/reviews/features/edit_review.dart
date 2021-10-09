import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class EditReview extends StatefulWidget {

  const EditReview({
    required Key key,
    required this.id
  }): super(key: key);

  final String id;

  @override
  _EditReviewState createState() => _EditReviewState();
}

class _EditReviewState extends State<EditReview> {

  _EditReviewState();

  late ReviewsBloc reviewsBloc;
  late Review review;
  late String id;

  @override
  void initState() {
    super.initState();
    reviewsBloc = context.read<ReviewsBloc>();
    review = reviewsBloc.state.getReviewById(id);
    id = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit the current review'),
        centerTitle: true,
      ),
      body: BlocListener<ReviewsBloc, ReviewsState>(
        listener: (BuildContext context, ReviewsState state) {
          if (state is LoadedReviews) {
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<ReviewsBloc, ReviewsState>(
          builder: (BuildContext context, ReviewsState state) {
            if (state is LoadingReviews) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SafeArea(
              child: SingleChildScrollView(
                child: ReviewEditor(
                  key: const Key('edit-review-card'),
                  review: review,
                  reviewFinished: (Review review, io.File image) {
                    reviewsBloc.add(AddNewReviewEvent(review, image));
                  },
                  reviewDeleted: (Review review) {
                    reviewsBloc.add(DeleteReviewEvent(review));
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}