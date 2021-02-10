import 'dart:async';
import 'package:flutter/services.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:firebase_storage/firebase_storage.dart' as storage;

import 'package:vegan_reviews/reviews/reviews.dart';

part 'reviews_event.dart';
part 'reviews_state.dart';
part 'reviews_service.dart';

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  
  ReviewsBloc(): super(NoReviews()) {
    reviewsService.onCollectionChanges((List<Review> reviews, List<String> deleted) {
      add(NewLoadedReviewsEvent(reviews, deleted));
    });
  }

  final ReviewsService reviewsService = ReviewsService();

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
    final modifiedReviewIds = event.reviews.map<String>((Review review) {
      return review.id;
    }).toList();
    final reviews = List<Review>.from(state.allPossibleReviews);
    final reviewsWithoutDeleted = reviews.where((Review element) {
      return !event.deleted.contains(element.id);
    }).toList();
    final reviewsWithoutModified = reviewsWithoutDeleted.where((Review element) {
      return !modifiedReviewIds.contains(element.id);
    }).toList();
    
    reviewsWithoutModified.addAll(event.reviews);
    
    yield LoadedReviews(reviewsWithoutModified);
  }

  Stream<ReviewsState> _mapAddNewReviewEventToState(AddNewReviewEvent event) async* {
    yield LoadingReviews(state.allPossibleReviews);
    await reviewsService.add(event.review);
  }

  Stream<ReviewsState> _mapEditReviewEventToState(EditReviewEvent event) async* {
    yield LoadingReviews(state.allPossibleReviews);
    await reviewsService.edit(event.review);
  }

  Stream<ReviewsState> _mapDeleteReviewEventToState(DeleteReviewEvent event) async* {
    yield LoadingReviews(state.allPossibleReviews);
    await reviewsService.delete(event.review);
  }
}
