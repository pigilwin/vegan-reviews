import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan_reviews/authentication/authentication.dart';
import 'package:vegan_reviews/reviews/features/about.dart';
import 'package:vegan_reviews/reviews/features/feed.dart';
import 'package:vegan_reviews/reviews/features/saved_feed.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> {

  late AuthenticationBloc authenticationBloc;
  PageController? pageController;

  @override
  void initState() {
    super.initState();
    authenticationBloc = context.read<AuthenticationBloc>();
    pageController = PageController(initialPage: 0);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _getCreateButton(),
        centerTitle: true,
        title: Text('Jody\'s Vegan Reviews'),
        actions: [
          _getAuthIcon()
        ],
      ),
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: pageController,
        children: [
          Feed(),
          SavedFeed(),
          About()
        ],
      ),
      bottomNavigationBar: Navigation(
        controller: pageController
      )
    );
  }

  Widget _getAuthIcon() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (_, AuthenticationState state) {
        if (state is Authenticated) {
          return IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              authenticationBloc.add(const SignOutEvent());
            },
          );
        }
        return IconButton(
          icon: Icon(Icons.login),
          onPressed: () {
            Navigator.of(context).pushNamed('/login');
          },
        );
      },
    );
  }

  Widget _getCreateButton() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (_, AuthenticationState state) {
        if (state is Authenticated) {
          return IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).pushNamed('/review/new');
            },
          );
        }
        return SizedBox.shrink();
      }
    );
  }
}