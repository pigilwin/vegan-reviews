import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class NewReview extends StatefulWidget {
  const NewReview({required Key key}) : super(key: key);


  @override
  _NewReviewState createState() => _NewReviewState();
}

class _NewReviewState extends State<NewReview> {

  late ReviewsBloc reviewsBloc;

  @override
  void initState() {
    super.initState();
    reviewsBloc = context.read<ReviewsBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a new review'),
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
                  review: Review.empty(),
                  reviewFinished: (Review review, io.File image) {
                    reviewsBloc.add(AddNewReviewEvent(review, image));
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