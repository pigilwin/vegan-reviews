part of 'reviews_bloc.dart';

abstract class ReviewsEvent{
  const ReviewsEvent();
}

class NewLoadedReviewsEvent extends ReviewsEvent {
  
  const NewLoadedReviewsEvent(this.reviews, this.deleted);

  final List<Review> reviews;
  final List<String> deleted;
}

class AddNewReviewEvent extends ReviewsEvent {
  
  const AddNewReviewEvent(this.review, this.image);

  final Review review;
  final io.File image;
}

class EditReviewEvent extends ReviewsEvent {
  
  const EditReviewEvent(this.review, this.image);

  final Review review;
  final io.File image;
}

class DeleteReviewEvent extends ReviewsEvent {
  
  const DeleteReviewEvent(this.review);

  final Review review;
}

class SaveReviewEvent extends ReviewsEvent {
  
  const SaveReviewEvent(this.review);

  final Review review;
}

class UnSaveReviewEvent extends ReviewsEvent {
  
  const UnSaveReviewEvent(this.review);

  final Review review;
}