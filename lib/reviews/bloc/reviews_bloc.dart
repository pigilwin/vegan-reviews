import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

part 'reviews_event.dart';
part 'reviews_state.dart';
part 'reviews_service.dart';

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  
  ReviewsBloc() {
    reviewsService.onCollectionChanges((List<Review> reviews, List<String> deleted) {
      add(NewLoadedReviewsEvent(reviews, deleted));
    });
  }

  final ReviewsService reviewsService = ReviewsService();
  
  @override
  ReviewsState get initialState => NoReviews();

  @override
  Stream<ReviewsState> mapEventToState(
    ReviewsEvent event,
  ) async* {

    if (event is NewLoadedReviewsEvent) {
      yield* _mapNewLoadedReviewsEventToState(event);
    }

    if (event is AddNewReviewEvent) {
      yield* _mapAddNewReviewEventToState(event);
    }

    if (event is EditReviewEvent) {
      yield* _mapEditReviewEventToState(event);
    }

    if (event is DeleteReviewEvent) {
      yield* _mapDeleteReviewEventToState(event);
    }
  }

  Stream<ReviewsState> _mapNewLoadedReviewsEventToState(NewLoadedReviewsEvent event) async* {
    final List<String> modifiedReviewIds = event.reviews.map<String>((Review review) {
      return review.id;
    }).toList();
    final List<Review> reviews = List.from(state.reviews);
    final List<Review> reviewsWithoutDeleted = reviews.where((Review element) {
      return !event.deleted.contains(element.id);
    }).toList();
    final List<Review> reviewsWithoutModified = reviewsWithoutDeleted.where((Review element) {
      return !modifiedReviewIds.contains(element.id);
    }).toList();
    reviewsWithoutModified.addAll(event.reviews);
    yield LoadedReviews(reviewsWithoutModified);
  }

  Stream<ReviewsState> _mapAddNewReviewEventToState(AddNewReviewEvent event) async* {
    yield LoadingReviews();
    await reviewsService.add(event.review);
  }

  Stream<ReviewsState> _mapEditReviewEventToState(EditReviewEvent event) async* {
    yield LoadingReviews();
    await reviewsService.edit(event.review);
  }

  Stream<ReviewsState> _mapDeleteReviewEventToState(DeleteReviewEvent event) async* {
    yield LoadingReviews();
    await reviewsService.delete(event.review);
  }
}
