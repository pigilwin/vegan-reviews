part of 'reviews_bloc.dart';

abstract class ReviewsEvent extends Equatable {
  const ReviewsEvent();
}

class LoadReviewsEvent extends ReviewsEvent {
  
  const LoadReviewsEvent();

  @override
  List<Object> get props => [];
}

class AddNewReviewEvent extends ReviewsEvent {
  
  const AddNewReviewEvent(this.review);

  final Review review;
  
  @override
  List<Object> get props => [review];
}

class EditReviewEvent extends ReviewsEvent {
  
  const EditReviewEvent(this.review);

  final Review review;
  
  @override
  List<Object> get props => [review];
}