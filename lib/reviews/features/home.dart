import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan_reviews/authentication/authentication.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

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

    if (state is LoadedReviews) {
      review = state.latestReview;
    }
    
    return SingleChildScrollView(
      child: Column(
        children: [
          Header(
            onlongPress: () {
              setState(() {
                tryingToSignIn = true;
              });
            },
          ),
          ReviewOverviewCard(
            review: review,
            onTap: (Review review) {
              Navigator.of(context).pushNamed('/review', arguments: review.id);
            },
            latestReview: true,
          ),
          FlatButton(
            color: Theme.of(context).primaryColor,
            child: const Text("Search for review?", style: TextStyle(fontSize: 20)),
            onPressed: () {
              Navigator.of(context).pushNamed('/search');
            },
          )
        ],
      ),
    );
  }
}