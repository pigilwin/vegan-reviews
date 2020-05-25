import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan_reviews/authentication/authentication.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> {
  
  bool tryingToSignIn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ReviewsBloc, ReviewsState>(
        builder: (BuildContext context, ReviewsState state) {
          if (tryingToSignIn) {
            return Column(
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
            );
          }
          return _homePage();
        },
      ),
    );
  }

  Widget _homePage() {
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
        ],
      ),
    );
  }
}