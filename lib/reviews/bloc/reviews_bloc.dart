import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    if (event is AddNewReviewEvent) {
      yield* _mapAddNewReviewEventToState(event);
    }
  }

  Stream<ReviewsState> _mapAddNewReviewEventToState(AddNewReviewEvent event) async* {
    yield const LoadingReviews();
    await reviewsService.add(event.review);
    yield LoadedReviews([]);
  }
}
