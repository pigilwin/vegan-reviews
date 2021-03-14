part of 'reviews_bloc.dart';

abstract class ReviewsState extends Equatable {
  
  const ReviewsState(
    this.reviews,
    this.savedReviews
  );

  final List<Review> reviews;
  final List<String> savedReviews;

  Review get latestReview {
    
    if (reviews.isEmpty) {
      return Review.empty();
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

  Review getReviewById(String? reviewId) {
    return reviews.firstWhere((Review element) {
      return element.id == reviewId;
    });
  }

  @override
  List<Object> get props => [
    reviews,
    savedReviews
  ];
}

class NoReviews extends ReviewsState {
  
  NoReviews(): super([], []);
}

class LoadingReviews extends ReviewsState {
  
  const LoadingReviews(
    List<Review> reviews,
    List<String> savedReviews
  ): super(
    reviews,
    savedReviews
  );
}

class LoadedReviews extends ReviewsState {
  
  const LoadedReviews(
    List<Review> reviews,
    List<String> savedReviews
  ): super(
    reviews,
    savedReviews
  );
}