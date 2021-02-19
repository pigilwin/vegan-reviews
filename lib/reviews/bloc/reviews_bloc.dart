import 'dart:async';
import 'dart:io' as io;
import 'package:flutter/services.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vegan_reviews/reviews/reviews.dart';

part 'reviews_event.dart';
part 'reviews_state.dart';
part 'reviews_service.dart';

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  
  ReviewsBloc(): super(NoReviews()){
    
    SharedPreferences.getInstance().then((value) {
      sharedPreferences = value;
    });
    
    reviewsService.onCollectionChanges((List<Review> reviews, List<String> deleted) {
      add(NewLoadedReviewsEvent(reviews, deleted));
    });
  }

  final ReviewsService reviewsService = ReviewsService();
  SharedPreferences sharedPreferences;

  static const String preferencesKey = 'savedReviews';

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

    if (event is SaveReviewEvent) {
      yield* _mapSaveReviewEventToState(event);
    }

    if (event is UnSaveReviewEvent) {
      yield* _mapUnSaveReviewEventToState(event);
    }
  }

  Stream<ReviewsState> _mapNewLoadedReviewsEventToState(NewLoadedReviewsEvent event) async* {  
    
    ///
    /// Find all review ids
    ///
    final modifiedReviewIds = event.reviews.map<String>((Review review) {
      return review.id;
    }).toList();
    
    ///
    /// Build a new list of reviews from the current state
    ///
    final reviews = List<Review>.from(state.reviews);
    
    ///
    /// Filter the current review list to remove the ones 
    /// that have been deleted
    ///
    final reviewsWithoutDeleted = reviews.where((Review element) {
      return !event.deleted.contains(element.id);
    }).toList();
    
    ///
    /// Filter the modiffied reviews
    ///
    final reviewsWithoutModified = reviewsWithoutDeleted.where((Review element) {
      return !modifiedReviewIds.contains(element.id);
    }).toList();
    
    ///
    /// Add all to the reviews
    ///
    reviewsWithoutModified.addAll(event.reviews);

    ///
    /// If we have never used the app before, save an empty list
    ///
    if (!sharedPreferences.containsKey(preferencesKey)) {
      await sharedPreferences.setStringList(preferencesKey, []);
    }

    ///
    /// Find the saved reviews that have been stored
    /// Loop through every saved review and remove the deleted ids
    ///
    final savedReviews = sharedPreferences.getStringList(preferencesKey).where((String savedId) {
      return !event.deleted.contains(savedId);
    }).toList();

    await sharedPreferences.setStringList(preferencesKey, savedReviews);

    yield LoadedReviews(reviewsWithoutModified.reversed.toList(), savedReviews);
  }

  Stream<ReviewsState> _mapAddNewReviewEventToState(AddNewReviewEvent event) async* {
    yield LoadingReviews(state.reviews, state.savedReviews);
    await reviewsService.add(event.review, event.image);
  }

  Stream<ReviewsState> _mapEditReviewEventToState(EditReviewEvent event) async* {
    yield LoadingReviews(state.reviews, state.savedReviews);
    await reviewsService.edit(event.review, event.image);
  }

  Stream<ReviewsState> _mapDeleteReviewEventToState(DeleteReviewEvent event) async* {
    yield LoadingReviews(state.reviews, state.savedReviews);
    await reviewsService.delete(event.review);
  }

  Stream<ReviewsState> _mapSaveReviewEventToState(SaveReviewEvent event) async* {
    yield LoadingReviews(state.reviews, state.savedReviews);
    final savedReviews = List<String>.from(state.savedReviews);
    savedReviews.add(event.review.id);
    await sharedPreferences.setStringList(preferencesKey, savedReviews);
    yield LoadedReviews(state.reviews, savedReviews);
  }

  Stream<ReviewsState> _mapUnSaveReviewEventToState(UnSaveReviewEvent event) async* {
    yield LoadingReviews(state.reviews, state.savedReviews);
    final savedReviews = List<String>.from(state.savedReviews).where((String savedId) {
      return event.review.id != savedId;
    }).toList();
    await sharedPreferences.setStringList(preferencesKey, savedReviews);
    yield LoadedReviews(state.reviews, savedReviews);
  }
}
