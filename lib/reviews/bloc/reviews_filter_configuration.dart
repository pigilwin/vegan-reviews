part of 'reviews_bloc.dart';

class ReviewsFilterConfiguration {
  const ReviewsFilterConfiguration({
    this.foodType,
    this.limited,
    this.stars
  });

  final String foodType;
  final bool limited;
  final int stars;
}