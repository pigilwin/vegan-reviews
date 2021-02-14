import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan_reviews/authentication/authentication.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class Feed extends StatefulWidget {

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {

  AuthenticationBloc authenticationBloc;

  @override
  void initState() {
    super.initState();
    authenticationBloc = context.read<AuthenticationBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewsBloc, ReviewsState>(
      builder: (context, ReviewsState state) {
        return ListView.builder(
          itemCount: state.reviews.length,
          itemBuilder: (context, i) {
            final review = state.reviews[i];
            return ReviewCard(
              review: review,
              onTap: () {
                if (authenticationBloc.state is Authenticated) {
                  Navigator.of(context).pushNamed('/review/edit', arguments: review.id);
                }
              },
            );
          }
        );
      },
    );
  }
}