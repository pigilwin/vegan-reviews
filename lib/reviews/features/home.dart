import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Jody\'s Vegan Reviews'),
      ),
      body: BlocBuilder<ReviewsBloc, ReviewsState>(
        builder: (context, ReviewsState state) {
          return ListView.builder(
            itemCount: state.allPossibleReviews.length,
            itemBuilder: (context, i) {
              final review = state.allPossibleReviews[i];
              return ReviewCard(
                review: review,
                onTap: (r) {

                }
              );
            }
          );
        },
      ),
      bottomNavigationBar: Navigation(),
    );
  }
}