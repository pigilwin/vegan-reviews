import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan_reviews/reviews/reviews.dart';
import 'package:vegan_reviews/shared/shared.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

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
        title: const Text("Search for a review"),
      ),
      body: BlocBuilder<ReviewsBloc, ReviewsState>(
        builder: (BuildContext builderContext, ReviewsState state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.all(5),
                  crossAxisCount: 2,
                  children: [
                    _getFoodTypeSelector(),
                    _getLimitedTypeSelector(),
                    _getStarAmountSelector()
                  ],
                ),
              ),
              Button(
                buttonText: 'Search',
                onPressed: () {
                  context.bloc<ReviewsBloc>().add(FilterReviewsEvent(
                    filterConfiguration: ReviewsFilterConfiguration(
                      foodType: foodType,
                      stars: stars,
                      limited: limited
                    )
                  ));
                  Navigator.of(context).pushNamed('/filtered');
                },
              )
            ],
          );
        },
      )
    );
  }

  Widget _getFoodTypeSelector() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: FoodTypeSelector(
            selected: (String value) {
              setState(() {
                foodType = value;
              });
            },
            value: foodType,
            validator: null,
          ),
        ),
      ),
    );
  }

  Widget _getLimitedTypeSelector() {
    return Card(
      child: Center(
        child: SwitchListTile(
          title: const Text("Only show limited items"),
          value: limited,
          onChanged: (bool v) {
            setState(() {
              limited = v;
            });
          },
        ),
      ),
    );
  }

  Widget _getStarAmountSelector() {
    return Card(
      child: Center(
        child: StarAmountChooser(
          value: stars,
          selected: (int choice) {
            setState(() {
              stars = choice;
            });
          },
        ),
      ),
    );
  }
}