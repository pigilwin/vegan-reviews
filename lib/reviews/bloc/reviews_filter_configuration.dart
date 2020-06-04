part of 'reviews_bloc.dart';

class ReviewsFilterConfiguration {
  const ReviewsFilterConfiguration({
    this.foodType,
    this.limited,
    this.stars
  });

  factory ReviewsFilterConfiguration.noFiltersApplied() {
    return const ReviewsFilterConfiguration(
      foodType: 'None Selected',
      limited: false,
      stars: null
    );
  }

  final String foodType;
  final bool limited;
  final int stars;
}