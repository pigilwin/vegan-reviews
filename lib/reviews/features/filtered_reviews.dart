import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class FilteredReviews extends StatefulWidget {
  @override
  _FilteredReviewsState createState() => _FilteredReviewsState();
}

class _FilteredReviewsState extends State<FilteredReviews> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String foodType;
  bool limited;
  int stars;

  @override
  void initState() {
    super.initState();
    final ReviewsState state = context.bloc<ReviewsBloc>().state;
    foodType = state.filterConfiguration.foodType;
    limited = state.filterConfiguration.limited;
    stars = state.filterConfiguration.stars;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Reviews by filter"),
      ),
      body: BlocBuilder<ReviewsBloc, ReviewsState>(
        builder: (BuildContext builderContext, ReviewsState state) {
          return GridView.builder(
            itemCount: state.filteredReviews.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (BuildContext context, int i) {
              return ReviewOverviewCard(
                review: state.filteredReviews[i],
                onTap: (Review review) {
                  Navigator.of(context).pushNamed('/review', arguments: [review.id]);
                },
              );
            }
          );
        },
      )
    );
  }
}