import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan_reviews/authentication/authentication.dart';
import 'package:vegan_reviews/reviews/reviews.dart';
import 'package:vegan_reviews/shared/shared.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> {
  
  bool tryingToSignIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (BuildContext context, AuthenticationState state) {
          if (state is Authenticated){
            setState(() {
              tryingToSignIn = false;
            });
          }
        },
        child: BlocBuilder<ReviewsBloc, ReviewsState>(
          builder: (BuildContext context, ReviewsState state) {
            if (tryingToSignIn) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Header(
                      onlongPress: () {
                        setState(() {
                          tryingToSignIn = false;
                        });
                      },
                    ),
                    SignInTile()
                  ],
                ),
              );
            }
            return _homePage(state);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _getAddNewReviewButton(),
    );
  }

  Widget _getAddNewReviewButton() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (BuildContext context, AuthenticationState state) {
        if (state is Authenticated){
          return FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed('/new-review');
            },
          );
        }
        return Container();
      },
    );
  }

  Widget _homePage(ReviewsState state) {
    
    Review review;
    Widget searchButton = const SizedBox.shrink();

    if (state.allPossibleReviews.isNotEmpty){
      review = state.latestReview;
      searchButton = Button(
        buttonText: 'Search for reviews',
        onPressed: () {
          Navigator.of(context).pushNamed('/search');
        },
      );
    }
    
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Header(
            onlongPress: () {
              setState(() {
                tryingToSignIn = true;
              });
            },
          ),
          searchButton,
          Padding(
            padding: const EdgeInsets.all(20),
            child: ReviewOverviewCard(
              review: review,
              onTap: (Review review) {
                Navigator.of(context).pushNamed('/review', arguments: review.id);
              },
              shrinkText: false,
              shrinkStars: false,
            ),
          ),
        ],
      ),
    );
  }
}