part of 'reviews_bloc.dart';

abstract class ReviewsState extends Equatable {
  const ReviewsState();
}

class NoReviews extends ReviewsState {
  
  const NoReviews();
  
  @override
  List<Object> get props => [];
}

class LoadingReviews extends ReviewsState {
  
  const LoadingReviews();

  @override
  List<Object> get props => [];
}

class LoadedReviews extends ReviewsState {
  
  const LoadedReviews(this.reviews);

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

    return reviews.first;
  }

  @override
  List<Object> get props => [];
}