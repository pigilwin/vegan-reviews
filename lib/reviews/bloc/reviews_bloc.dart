import 'dart:async';
import 'dart:io' as io;

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

part 'reviews_event.dart';
part 'reviews_state.dart';
part 'reviews_service.dart';

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  
  final ReviewsService reviewsService = ReviewsService();
  
  @override
  ReviewsState get initialState => const NoReviews();

  @override
  Stream<ReviewsState> mapEventToState(
    ReviewsEvent event,
  ) async* {

    if (event is LoadReviewsEvent) {
      yield* _mapLoadReviewsEventToState();
    }

    if (event is AddNewReviewEvent) {
      yield* _mapAddNewReviewEventToState(event);
    }

    if (event is EditReviewEvent) {
      yield* _mapEditReviewEventToState(event);
    }
  }

  Stream<ReviewsState> _mapLoadReviewsEventToState() async* {
    yield const LoadingReviews();
    final List<Review> reviews = await reviewsService.fetch();
    yield LoadedReviews(reviews);
  }

  Stream<ReviewsState> _mapAddNewReviewEventToState(AddNewReviewEvent event) async* {
    yield const LoadingReviews();
    await reviewsService.add(event.review);
    final List<Review> reviews = await reviewsService.fetch();
    yield LoadedReviews(reviews);
  }

  Stream<ReviewsState> _mapEditReviewEventToState(EditReviewEvent event) async* {
    yield const LoadingReviews();
    await reviewsService.edit(event.review);
    final List<Review> reviews = await reviewsService.fetch();
    yield LoadedReviews(reviews);
  }
}
