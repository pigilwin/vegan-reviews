import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan_reviews/authentication/authentication.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ReviewsBloc, ReviewsState>(
        builder: (BuildContext context, ReviewsState state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Header(),
                _getButton()
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _getButton() {
    return RaisedButton.icon(
      color: Theme.of(context).primaryColor,
      icon: const Icon(Icons.arrow_forward, color: Colors.white),
      onPressed: () {
        context.bloc<AuthenticationBloc>().add(const RequestAuthenticationEvent());
      },
      animationDuration: const Duration(seconds: 5),
      label: const Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 20))
    );
  }
}