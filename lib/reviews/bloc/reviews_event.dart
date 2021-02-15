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
  
  const AddNewReviewEvent(this.review, this.image);

  final Review review;
  final io.File image;
  
  @override
  List<Object> get props => [review, image];
}

class EditReviewEvent extends ReviewsEvent {
  
  const EditReviewEvent(this.review, this.image);

  final Review review;
  final io.File image;
  
  @override
  List<Object> get props => [review, image];
}

class DeleteReviewEvent extends ReviewsEvent {
  
  const DeleteReviewEvent(this.review);

  final Review review;
  
  @override
  List<Object> get props => [review];
}