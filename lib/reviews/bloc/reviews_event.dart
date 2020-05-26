part of 'reviews_bloc.dart';

abstract class ReviewsEvent extends Equatable {
  const ReviewsEvent();
}

class AddNewReviewEvent extends ReviewsEvent {
  
  const AddNewReviewEvent(this.review);

  final Review review;
  
  @override
  List<Object> get props => [review];
}