part of 'reviews_bloc.dart';

abstract class ReviewsEvent extends Equatable {
  const ReviewsEvent();
}

class NewLoadedReviewsEvent extends ReviewsEvent {
  
  const NewLoadedReviewsEvent(this.reviews, this.deleted);

  final List<Review> reviews;
  final List<String> deleted;

  @override
  List<Object> get props => [reviews, deleted];
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

class DeleteReviewEvent extends ReviewsEvent {
  
  const DeleteReviewEvent(this.review);

  final Review review;
  
  @override
  List<Object> get props => [review];
}

class FilterReviewsEvent extends ReviewsEvent {

  const FilterReviewsEvent({
    this.foodType,
    this.limited,
    this.stars
  });

  final String foodType;
  final bool limited;
  final int stars;

  @override
  List<Object> get props => [
    foodType,
    limited,
    stars
  ];
}