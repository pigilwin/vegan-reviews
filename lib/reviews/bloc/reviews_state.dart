part of 'reviews_bloc.dart';

abstract class ReviewsState extends Equatable {
  const ReviewsState(this.reviews);

  final List<Review> reviews;

  Review get latestReview {
    
    if (reviews.isEmpty) {
      return null;
    }
    
    reviews.sort((Review first, Review second) {
      if (first.created.isAfter(second.created)) {
        return 1;
      }
      if (first.created.isAtSameMomentAs(second.created)) {
        return 0;
      }
      return -1;
    });

    return reviews.last;
  }

  Review getReviewById(String reviewId) {
    return reviews.firstWhere((Review element) {
      return element.id == reviewId;
    });
  }

  @override
  List<Object> get props => [reviews];
}

class NoReviews extends ReviewsState {
  
  NoReviews(): super([]);
}

class LoadingReviews extends ReviewsState {
  
  const LoadingReviews(List<Review> reviews): super(reviews);
}

class LoadedReviews extends ReviewsState {
  
  const LoadedReviews(List<Review> reviews): super(reviews);
}