part of 'reviews_bloc.dart';

abstract class ReviewsState extends Equatable {
  
  const ReviewsState(
    this.allPossibleReviews
  );

  final List<Review> allPossibleReviews;

  Review get latestReview {
    
    if (allPossibleReviews.isEmpty) {
      return Review.empty();
    }
    
    allPossibleReviews.sort((Review first, Review second) {
      if (first.created.isAfter(second.created)) {
        return 1;
      }
      if (first.created.isAtSameMomentAs(second.created)) {
        return 0;
      }
      return -1;
    });

    return allPossibleReviews.last;
  }

  Review getReviewById(String reviewId) {
    return allPossibleReviews.firstWhere((Review element) {
      return element.id == reviewId;
    });
  }

  @override
  List<Object> get props => [
    allPossibleReviews
  ];
}

class NoReviews extends ReviewsState {
  
  NoReviews(): super([]);
}

class LoadingReviews extends ReviewsState {
  
  const LoadingReviews(
    List<Review> reviews
  ): super(
    reviews
  );
}

class LoadedReviews extends ReviewsState {
  
  const LoadedReviews(
    List<Review> reviews,
  ): super(
    reviews
  );
}