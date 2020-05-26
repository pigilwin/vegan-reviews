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

  @override
  List<Object> get props => [];
}