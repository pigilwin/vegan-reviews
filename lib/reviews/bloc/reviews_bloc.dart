import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

part 'reviews_event.dart';
part 'reviews_filter_configuration.dart';
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

    if (event is FilterReviewsEvent) {
      yield* _mapFilterReviewsEventToState(event);
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
    yield LoadedReviews(reviewsWithoutModified, reviewsWithoutModified, state.filterConfiguration);
  }

  Stream<ReviewsState> _mapAddNewReviewEventToState(AddNewReviewEvent event) async* {
    yield LoadingReviews(
      state.allPossibleReviews, 
      state.filteredReviews, 
      state.filterConfiguration
    );
    await reviewsService.add(event.review);
  }

  Stream<ReviewsState> _mapEditReviewEventToState(EditReviewEvent event) async* {
    yield LoadingReviews(
      state.allPossibleReviews, 
      state.filteredReviews, 
      state.filterConfiguration
    );
    await reviewsService.edit(event.review);
  }

  Stream<ReviewsState> _mapDeleteReviewEventToState(DeleteReviewEvent event) async* {
    yield LoadingReviews(
      state.allPossibleReviews, 
      state.filteredReviews, 
      state.filterConfiguration
    );
    await reviewsService.delete(event.review);
  }

  Stream<ReviewsState> _mapFilterReviewsEventToState(FilterReviewsEvent event) async* {
    final allPossibleReviews = List<Review>.from(state.allPossibleReviews);
    final filteredReviews = allPossibleReviews.where((Review review) {
      if (event.filterConfiguration.stars != null) {
        if (review.stars < event.filterConfiguration.stars) {
          return false;
        }
      }

      if (event.filterConfiguration.limited != review.limited) {
        return false;
      }

      if (event.filterConfiguration.foodType != 'none') {
        if (event.filterConfiguration.foodType != review.type){
          return false;
        }
      }

      return true;
    }).toList();
    yield LoadedReviews(allPossibleReviews, filteredReviews, event.filterConfiguration);
  }
}
