part of 'reviews_bloc.dart';

abstract class ReviewsState extends Equatable {
  
  const ReviewsState(this.allPossibleReviews, this.filteredReviews);

  final List<Review> allPossibleReviews;
  final List<Review> filteredReviews;

  Review get latestReview {
    
    if (allPossibleReviews.isEmpty) {
      return null;
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
  List<Object> get props => [allPossibleReviews];
}

class NoReviews extends ReviewsState {
  
  NoReviews(): super([], []);
}

class LoadingReviews extends ReviewsState {
  
  const LoadingReviews(List<Review> reviews, List<Review> filteredReviews): super(reviews, filteredReviews);
}

class LoadedReviews extends ReviewsState {
  
  const LoadedReviews(List<Review> reviews, List<Review> filteredReviews): super(reviews, filteredReviews);
}