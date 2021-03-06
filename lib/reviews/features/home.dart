import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan_reviews/authentication/authentication.dart';
import 'package:vegan_reviews/reviews/features/about.dart';
import 'package:vegan_reviews/reviews/features/feed.dart';
import 'package:vegan_reviews/reviews/features/saved_feed.dart';
import 'package:vegan_reviews/reviews/reviews.dart';

class Home extends StatefulWidget {
  
  const Home({required Key key}) : super(key: key);

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
        title: const Text('Jody\'s Vegan Reviews'),
        actions: [
          _getAuthIcon()
        ],
      ),
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: pageController,
        children: const [
          Feed(key: Key('feed-page'),),
          SavedFeed(key: Key('saved-feed-page'),),
          About(key: Key('about-page'),)
        ],
      ),
      bottomNavigationBar: Navigation(
        controller: pageController, 
        key: const Key('navigation-bar'),
      )
    );
  }

  Widget _getAuthIcon() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (_, AuthenticationState state) {
        if (state is Authenticated) {
          return IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authenticationBloc.add(const SignOutEvent());
            },
          );
        }
        return IconButton(
          icon: const Icon(Icons.login),
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
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).pushNamed('/review/new');
            },
          );
        }
        return const SizedBox.shrink();
      }
    );
  }
}