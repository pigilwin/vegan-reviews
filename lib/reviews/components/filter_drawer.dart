import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan_reviews/reviews/reviews.dart';
import 'package:vegan_reviews/shared/shared.dart';

class FilterDrawer extends StatefulWidget {
  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  
  bool limitedTime = false;
  String foodType;
  int stars;

  @override
  void initState() {
    super.initState();
    final ReviewsFilterConfiguration filterConfiguration = context.bloc<ReviewsBloc>().state.filterConfiguration;
    limitedTime = filterConfiguration.limited;
    foodType = filterConfiguration.foodType;
    stars = filterConfiguration.stars;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: VeganGradient.gradient(0.2)
        ),
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            const DrawerHeader(
              child: Center(
                child: Text("Filter Reviews", style: TextStyle(fontSize: 22)),
              ),
            ),
            SwitchListTile(
              onChanged: (bool changed) {
                setState(() {
                  limitedTime = changed;
                });
                submitFilterRequest();
              },
              value: limitedTime,
              title: const Text("Limited time items only"),
            ),
            FoodTypeSelector(
              selected: (String type){
                setState(() {
                  foodType = type;
                });
                submitFilterRequest();
              },
              value: foodType,
            ),
            StarAmountChooser(
              value: stars,
              selected: (int v) {
                setState(() {
                  stars = v;
                });
                submitFilterRequest();
              },
            )
          ],
        ),
      ),
    );
  }

  void submitFilterRequest() {
    context.bloc<ReviewsBloc>().add(FilterReviewsEvent(filterConfiguration: ReviewsFilterConfiguration(
      foodType: foodType,
      limited: limitedTime,
      stars: stars
    )));
  }
}