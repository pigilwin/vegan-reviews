part of 'reviews_bloc.dart';

abstract class ReviewsState extends Equatable {
  const ReviewsState();
}

class ReviewsInitial extends ReviewsState {
  @override
  List<Object> get props => [];
}
